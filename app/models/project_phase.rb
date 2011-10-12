class ProjectPhase < ActiveRecord::Base
  belongs_to :project
  belongs_to :lifecycle_phase

  has_many :stock_deliverable_types
  has_many :deliverable_types, :through => :stock_deliverable_types

  validates :lifecycle_phase_id,  :presence => true
  validates :project_id,          :presence => true

  def estimated_effort
    @stock_deliverables =
        Deliverable.where(["assignable_type=?", "StockDeliverableType"]).find(:all,
          :joins => "INNER JOIN stock_deliverable_types ON deliverables.assignable_id=stock_deliverable_types.id
          INNER JOIN project_phases ON project_phases.id=stock_deliverable_types.project_phase_id",
          :conditions => ["project_phases.id = ?", id])

    total_estimated_effort = 0
    @stock_deliverables.each do |deliverable|
      total_estimated_effort += deliverable.estimated_effort unless deliverable.nil?
    end

    return total_estimated_effort
  end
end
