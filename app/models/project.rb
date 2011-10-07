class Project < ActiveRecord::Base
  belongs_to :lifecycle
  has_many :project_phases
  has_many :lifecycle_phases, :through => :project_phases, :foreign_key => "lifecycle_phase_id"
  
  validates :name, :presence => true, :uniqueness => true
  validates :lifecycle_id, :presence => true
end
