class UsersController < ApplicationController

  skip_before_action :require_login

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
    user = User.find(session[:current_user_id])
    # need a rake task that gets all corp members populates Character
    # currently just relies on getting from Killmail
    @character = Character.find_by(name: user.name)
    character_id = @character.character_id
    @character_image = "#{character_id}" + ".jpg"
  end

end
