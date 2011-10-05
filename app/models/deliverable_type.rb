class DeliverableType < ActiveRecord::Base
  belongs_to :lifecycle_phase
  belongs_to :unit_of_measure
  
  validates :name, :presence => true, :uniqueness => true
  validates :lifecycle_phase_id, :presence => true
  
end
