# This model represents the phases associated with a given project. It is a
# join table, that establishes a many-to-many relationship between
# LifecyclePhase and Project

class ProjectPhase < ActiveRecord::Base
  belongs_to :project
  belongs_to :lifecycle_phase

  has_many :stock_deliverable_types
  has_many :custom_deliverable_types
  has_many :deliverable_types, :through => :stock_deliverable_types

  validates :lifecycle_phase_id, :presence => true
  validates :project_id, :presence => true

  # Returns estimated effort for a ProjectPhase by calculating the sum of the
  # estimated effort for each StockDeliverableType and CustomDeliverableType
  def estimated_effort
    total_estimated_effort = 0

    self.project_phase_deliverables.each do |deliverable|
      total_estimated_effort += deliverable.estimated_effort.to_f unless deliverable.nil?
    end

    return total_estimated_effort
  end
  
  # function to get the total logged effort for this deliverable
  def logged_effort
    total_logged_effort = 0

    self.project_phase_deliverables.each do |deliverable|
      total_logged_effort += deliverable.logged_effort.to_f unless deliverable.nil?
    end

    return total_logged_effort
  end  
  
  # function to return the aggregated project phase deliverables with both stock and custom
  def project_phase_deliverables
    project_phase_deliverables = []
    stock_deliverable_types.each do |stock|
      stock.deliverables.each do |d|
        project_phase_deliverables << d
      end
    end

    custom_deliverable_types.each do |custom|
      custom.deliverables.each do |d|
        project_phase_deliverables << d
      end
    end
    project_phase_deliverables
  end
  
end
