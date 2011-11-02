class UnitOfMeasure < ActiveRecord::Base
  has_many :deliverable_types
  has_many :custom_deliverable_types

  validates :unit, :presence => true
end
