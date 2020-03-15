class User < ApplicationRecord

   def self.logout(session)
     user = self.find(session[:current_user_id])
     user.update(login_status: false)
   end

   def self.eve_login(callback_auth_code)
     response = get_auth_response(callback_auth_code)
     token = JSON.parse(response)['access_token']

     if token == nil
       return false
     end

     result_hash      = jwt_verify(token)
     user             = self.find_by(name: result_hash['name'])
     eve_character_id = result_hash['sub'].split(':').last.to_i
     if validate_users_corp(eve_character_id) == true
       if result_hash && user # If the eve access token is verified and they are already in the User table, just update login_status = true
         user.update(login_status: true)
         user.save!
         unless Character.find_by(character_id: eve_character_id)
           Character.character_import([eve_character_id])
         end
         @user = user
         # update session and redirect to landing
       elsif result_hash # otherise if verified, ( but not in user table, add them )
         user = self.create(name: result_hash['name'], login_status: true)
         user.save!
         unless Character.find_by(character_id: eve_character_id)
           Character.character_import([eve_character_id])
         end
         @user = user
         # update session and redirect to landing
       else # not verified, and
         return false
         # redirect to landing page with a warning login failed,
         # or not allowed to login
       end
     else
       return false
     end
   end

   def self.validate_users_corp(character_id)
     Character.check_character(character_id)
   end

   def self.public_key_pem
     begin
       OpenSSL::PKey::RSA.new(File.read('config/login_eve_public_key_rsa'))
     rescue StandardError
       return false
     end
   end

   def self.jwt_verify(token)
     begin
       jwt = JWT.decode(token, public_key_pem, true, {algorithm: 'RS256'})
       key_hash = jwt.first
     rescue StandardError
       return false
     end
     if key_hash['iss'] == "login.eveonline.com" && Time.at(key_hash['exp']).utc > Time.now.utc
       return key_hash
     else
      false
     end
   end

   def self.get_auth_response(callback_auth_code)
     uri = URI.parse("https://login.eveonline.com/v2/oauth/token")
     request = Net::HTTP::Post.new(uri)
     request.content_type = "application/x-www-form-urlencoded"
     request["Authorization"] = "Basic #{ENV['BASE64_ENCODE']}"
     request.set_form_data(
       'grant_type' => 'authorization_code',
       'code' => callback_auth_code
     )
     req_options = {
      use_ssl: uri.scheme == "https",
     }
     response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
       http.request(request)
     end
     return response.body
   end

end
