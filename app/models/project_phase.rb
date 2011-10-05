class ProjectPhase < ActiveRecord::Base
  belongs_to :project
  belongs_to :lifecycle_phase
  
  validates :lifecycle_phase_id,  :presence => true
  validates :project_id,          :presence => true
end
