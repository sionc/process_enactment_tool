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

    @project_phase_deliverables = []
    stock_deliverable_types.each do |stock|
      stock.deliverables.each do |d|
        @project_phase_deliverables << d
      end
    end

    custom_deliverable_types.each do |custom|
      custom.deliverables.each do |d|
        @project_phase_deliverables << d
      end
    end

    total_estimated_effort = 0

    @project_phase_deliverables.each do |deliverable|
      total_estimated_effort += deliverable.estimated_effort.to_f unless deliverable.nil?
    end

    return total_estimated_effort
  end
end
