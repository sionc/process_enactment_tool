class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
 
  after_create :assign_user_role
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_and_belongs_to_many :roles
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  private

  def assign_user_role
    self.roles << Role.find_by_name("regular_user")
    self.save!
  end
 
end
