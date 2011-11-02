class CustomDeliverableType < ActiveRecord::Base
  belongs_to :project_phase
  belongs_to :unit_of_measure

  has_many :deliverables, :as => :assignable
end
