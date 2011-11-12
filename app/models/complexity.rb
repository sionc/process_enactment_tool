# This model represents the complexity of a deliverable. There are three
# complexity values (low, medium, and high), which are seeded by db/seeds.rb.

class Complexity < ActiveRecord::Base
  has_many :deliverables

  validates :level, :presence => true
end
