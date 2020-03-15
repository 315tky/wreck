class ApplicationController < ActionController::Base

layout 'application'
before_action :set_layout_variables

 def set_layout_variables
   if session[:current_user_id]
     @user_name = User.find_by(id: session[:current_user_id]).name
   end
 end

end
