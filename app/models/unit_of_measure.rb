class UnitOfMeasure < ActiveRecord::Base
  validates :unit, :presence => true
end
