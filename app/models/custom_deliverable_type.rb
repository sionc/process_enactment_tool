class CustomDeliverableType < ActiveRecord::Base
  belongs_to :project_phase
  belongs_to :unit_of_measure

  has_many :deliverables, :as => :assignable

  validates :name, :presence => true
  validates :project_phase_id, :presence => true
  validates :unit_of_measure, :presence => true

end
