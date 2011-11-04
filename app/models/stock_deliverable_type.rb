class StockDeliverableType < ActiveRecord::Base

  belongs_to :project_phase
  belongs_to :deliverable_type

  has_many :deliverables, :as => :assignable

  validates :deliverable_type_id, :presence => true
  validates :project_phase_id, :presence => true

end
