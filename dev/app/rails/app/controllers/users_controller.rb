class UsersController < ApplicationController

  def login
    begin
      @user = User.eve_login(params[:code])
      session[:current_user_id] = @user.id
      redirect_to users_path(@user)
    rescue StandardError
      flash[:notice] = 'EVE SSO Login attempt failed, or you do not have permission to view this site.'
      redirect_to home_index_url
    end
  end

  def logout
    User.logout(session)
    reset_session
    redirect_to home_index_url
  end

  def show
    @user = User.find(session[:current_user_id])
  end

end
