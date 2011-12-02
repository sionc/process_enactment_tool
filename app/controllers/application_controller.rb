class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all

  before_filter :get_user

  
  # check_authorization
  
  # Present the user with an error message if they do not
  # have permission to view this page
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end
  
  # Make the current user object available to views
  #----------------------------------------
  def get_user
    @current_user ||= current_user
  end

  # Get roles accessible by the current user
  #----------------------------------------------------
  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability,:read)
  end
  
end
