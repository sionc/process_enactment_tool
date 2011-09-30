class Project < ActiveRecord::Base
  belongs_to :lifecycle
  
  validates :name, :presence => true
  validates :lifecycle_id, :presence => true
end
