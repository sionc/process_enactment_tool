class Lifecycle < ActiveRecord::Base
 has_many :projects
 has_many :lifecycle_phases

 validates :name, :presence => true
end