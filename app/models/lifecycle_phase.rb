# This model represents the pre-defined lifecycle phases. Lifecycles have many
# lifecycle phases; each project phase belongs to a lifecycle phase.
# Deliverable types are pre-defined for each lifecycle phase.

class LifecyclePhase < ActiveRecord::Base
  belongs_to :lifecycle
  has_many :project_phases
  has_many :projects, :through => :project_phases, :foreign_key => "project_id"
  has_many :deliverable_types

  validates :lifecycle_id, :presence => true
end
