# This model represents user-created projects. Each project is associated with
# a lifecycle, and has a collection of project phases.

class Project < ActiveRecord::Base
  belongs_to :lifecycle
  has_many :project_phases
  has_many :lifecycle_phases, :through => :project_phases, :foreign_key => "lifecycle_phase_id" do
    def ordered_list
      find :all, :order => "sequence_number asc"
    end
  end
  
  validates :name, :presence => true, :uniqueness => true
  validates :lifecycle_id, :presence => true

  # Returns the estimated effort for the Project by taking the sum of
  # the estimated effort for ProjectPhase
  def estimated_effort
    total_estimated_effort = 0
    project_phases.each do |phase|
      total_estimated_effort += phase.estimated_effort unless phase.nil?
    end

    total_estimated_effort
  end

  # Returns the logged effort for the Project 
  def logged_effort
    total_logged_effort = 0
    project_phases.each do |phase|
      total_logged_effort += phase.logged_effort unless phase.nil?
    end

    total_logged_effort
  end

end
