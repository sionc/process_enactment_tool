class ProjectPhase < ActiveRecord::Base
  belongs_to :project
  belongs_to :lifecycle_phase

  has_many :stock_deliverable_types
  has_many :deliverable_types, :through => :stock_deliverable_types

  validates :lifecycle_phase_id,  :presence => true
  validates :project_id,          :presence => true
end
