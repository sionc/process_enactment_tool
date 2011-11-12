# This model represents the stock deliverable types that can be created by
# the user.

class DeliverableType < ActiveRecord::Base
  belongs_to :lifecycle_phase
  belongs_to :unit_of_measure

  has_many :stock_deliverable_types
  has_many :project_phases, :through => :stock_deliverable_types

  validates :name, :presence => true
  validates :lifecycle_phase_id, :presence => true
  validates :unit_of_measure_id, :presence => true
  
end
