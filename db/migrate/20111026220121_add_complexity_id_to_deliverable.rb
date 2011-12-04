# Migration for adding complexity id to deliverable

class AddComplexityIdToDeliverable < ActiveRecord::Migration
  # Add column
  def self.up
    add_column :deliverables, :complexity_id, :integer
  end

  # Remove column
  def self.down
    remove_column :deliverables, :complexity_id
  end
end
