class ApplicationController < ActionController::Base

  layout 'application'
  before_action :set_layout_variables

  def set_layout_variables
    if session[:current_user_id]
      @user_name = User.find_by(id: session[:current_user_id]).name
    end
  end

  before_action :require_login

  private

  def require_login
    unless logged_in?
      redirect_to home_index_path
    end
  end

  def logged_in?
    if session[:current_user_id]
      return true
    end
  end

end
