class LifecyclePhase < ActiveRecord::Base
  belongs_to :lifecycle
  has_many :project_phases
  has_many :projects, :through => :project_phases, :foreign_key => "project_id"

  validates :lifecycle_id, :presence => true
end
