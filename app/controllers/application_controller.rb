class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # check_authorization
  
  # Present the user with an error message if they do not
  # have permission to view this page
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  
end
