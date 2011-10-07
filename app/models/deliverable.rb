class Deliverable < ActiveRecord::Base

  belongs_to :project_deliverable_type, :polymorphic => true

  validates :name, :presence => true
  validates :project_deliverable_type_id, :presence => true
  validates :project_deliverable_type_type, :presence => true

end
