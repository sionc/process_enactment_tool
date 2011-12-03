# This model represents the pre-defined lifecycle phases. Lifecycles have many
# lifecycle phases; each project phase belongs to a lifecycle phase.
# Deliverable types are pre-defined for each lifecycle phase.

class LifecyclePhase < ActiveRecord::Base
  belongs_to :lifecycle
  has_many :project_phases
  has_many :projects, :through => :project_phases, :foreign_key => "project_id"
  has_many :deliverable_types

  validates :lifecycle_id, :presence => true
  validates :name, :presence => true
  validates :sequence_number, :presence => true

  validate :unique_sequence_number
  validate :sequence_number_range

  # Custom validator to check uniqueness of the sequence number
  def unique_sequence_number
    unless self.lifecycle.nil?
        if(lifecycle.lifecycle_phases.find_all_by_sequence_number(self.sequence_number).count > 0)
           errors.add(:sequence_number, "must be unique for this lifecycle")
        end
    end
  end

  # Custom validator to check whether sequence number is within acceptable range
  # The sequence numbering starts at 1.
  # However, we need an extra placeholder for swapping sequence numbers.
  # So, we use 0 as the temporary swap number.
  def sequence_number_range
    unless self.lifecycle.nil? || self.sequence_number.nil?
        if((self.sequence_number > lifecycle.lifecycle_phases.count+1) || (self.sequence_number < 0) )
           errors.add(:sequence_number, "must not exceed the number of lifecycle phases and must be greater than 0")
        end
    end
  end
end
