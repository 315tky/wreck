class UserController < ApplicationController

  def login
    unless User.eve_login(params[:code])
      flash[:notice] = 'EVE SSO Login attempt failed, or you do not have permission to view this site.'
      redirect_to home_index_url
    end
  end

  def logout
  end

end
