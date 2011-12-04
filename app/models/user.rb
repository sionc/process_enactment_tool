# This model represents a user

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
 
  after_create :assign_user_role
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role

  has_and_belongs_to_many :roles
  has_many :effort_logs

  # Create a 'role' virtual attribute
  def role
    first_role = self.roles.first unless self.roles.nil?
    if (first_role.nil?)
      return "(none)"
    else
      return first_role.name
    end
  end

  # Sets a 'role' to the user
  def role=(role_id)
    self.roles = [Role.find(role_id)]
  end

  # Gets the user role
  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end
  
  private

  # Assigns default user role before saving the record
  def assign_user_role
    self.roles << Role.find_by_name("regular_user")
    self.save!
  end 
end
