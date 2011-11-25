class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Present the user with an error message if they do not
  # have permission to view this page
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
end
