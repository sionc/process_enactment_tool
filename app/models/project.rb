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

  def estimated_effort
    total_estimated_effort = 0
    project_phases.each do |phase|
      total_estimated_effort += phase.estimated_effort unless phase.nil?
    end

    return total_estimated_effort
  end

end
