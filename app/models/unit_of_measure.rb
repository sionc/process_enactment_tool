# This model represents the unit of measure associated with a DeliverableType
# or a CustomDeliverableType. Units of measure are seeded in db/seeds.rb, and
# are not changeable by the user.

class UnitOfMeasure < ActiveRecord::Base
  has_many :deliverable_types
  has_many :custom_deliverable_types

  validates :unit, :presence => true
end
