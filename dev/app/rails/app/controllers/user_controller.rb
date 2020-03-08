class UserController < ApplicationController

  def login
    user = User.new(params[:code])
  #  @access_token = user.get_auth_response
     @access_token = user.eve_login
  end

  def logout
  end

end
