# This model represents the different roles of users. eg. Administrator and Regular User

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
end
