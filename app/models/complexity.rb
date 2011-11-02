class Complexity < ActiveRecord::Base
  has_many :deliverables

  validates :level, :presence => true
end
