require 'dm-rails/middleware/identity_map'
class ApplicationController < ActionController::Base
  use Rails::DataMapper::Middleware::IdentityMap
  protect_from_forgery
  enable_authorization do |exception|
    redirect_to root_url, :alert => exception.message
  end unless :devise_controller?

 
  rescue_from CanCan::Unauthorized do |exception|
    flash[:error] = exception.message
    if user_signed_in?
     # debugger
      redirect_to((request.referer || root_url), {notice: "sorry you are not authorised to #{params[:action]} this issue"})
    else
      # Adds the protected page to the login url but only if the user is not logged in
      redirect_to new_user_session_path, {notice: "sorry you are not authorised to do this operation without login"}
    end
  end


end
      
      
