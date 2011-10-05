class LifecyclePhase < ActiveRecord::Base
  belongs_to :lifecycle
  has_many :project_phases
  
  validates :lifecycle_id, :presence => true
end
