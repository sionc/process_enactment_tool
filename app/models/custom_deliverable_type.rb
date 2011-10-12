class CustomDeliverableType < ActiveRecord::Base
  belongs_to :project_phase
  has_many :deliverables, :as => :assignable
end
