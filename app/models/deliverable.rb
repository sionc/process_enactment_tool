class Deliverable < ActiveRecord::Base

  validates :name, :presence => true
  validates :project_deliverable_type_id, :presence => true

end
