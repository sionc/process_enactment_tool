class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
 
  after_create :assign_user_role
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_and_belongs_to_many :roles

  # Create a 'role' virtual attribute
  def role
    first_role = self.roles.first unless self.roles.nil?
    if (first_role.nil?)
      return "(none)"
    else
      return first_role.name
    end
  end
  
  def role=(role_name)
    self.roles.empty!
    self.roles << Role.find_by_name(role_name)
  end
    
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  private

  def assign_user_role
    self.roles << Role.find_by_name("regular_user")
    self.save!
  end
 
end
