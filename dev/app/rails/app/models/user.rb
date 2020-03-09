class User < ApplicationRecord


   def self.eve_login(callback_auth_code)
     response = get_auth_response(callback_auth_code)
     jwt_access_token = JSON.parse(response)
     result = verify_jwt(jwt_access_token['access_token'])
     if result && self.find_by(name: result) # If they are verified and they are already in the User table, just update login_status = true
       return false
       #user = self.update(login_status: true)
       # update session and redirect to landing
     elsif result # otherise if verified, ( but not in user table, add them )
       user = self.create(name: result, login_status: true) #
       user.save!
       # update session and redirect to landing
     else # not verified, and
       # redirect to landing page with a warning login failed,
       # or not allowed to login
     end
   end

   def self.public_key_pem
     OpenSSL::PKey::RSA.new(File.read('config/login_eve_public_key_rsa'))
   end

   def self.verify_jwt(token)
     jwt = JWT.decode(token, public_key_pem, true, {algorithm: 'RS256'})
     key_hash = jwt.first # need to put a catch in here to avoid a nil error etc, if the jwt check fails
     if Character.find_by(name: 'Takamori Saig0') && key_hash['iss'] == "login.eveonline.com" && Time.at(key_hash['exp']).utc > Time.now.utc
       return key_hash['name']
     else
      false
     end
    #return Character.find_by(name: key_hash['name'])
     #end
     #values = [name, iss, exp]
     #return values
     # check expiry and the iss, and the name of the person,
     # look up character id, and check corp id, if
     # true then set login_status to true,
     # need a rake task to regularly check user login_status
     # for any that are true, then check last_update time,
     # if more than 6 hours, then set to false
     # Have a check when user hits login - need to do something with cookies ?
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
