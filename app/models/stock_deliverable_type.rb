class StockDeliverableType < ActiveRecord::Base

  belongs_to :project_phase
  belongs_to :deliverable_type

end
