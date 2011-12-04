# Helper class for users

module UsersHelper
  
  # Return a string containing the first user role (if present)
  def get_user_role(user)
    roles = user.roles.collect{|r| r.name}
    if roles.empty?
      return "(none)"      
    else
      return roles[0]
    end
  end
  
end
