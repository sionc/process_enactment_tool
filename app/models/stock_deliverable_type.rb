class StockDeliverableType < ActiveRecord::Base

  belongs_to :project_phase
  belongs_to :deliverable_type

  has_many :deliverables, :as => :assignable

end