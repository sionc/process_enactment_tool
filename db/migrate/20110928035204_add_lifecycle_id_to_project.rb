# Migration for adding a lifecycle id to a project

class AddLifecycleIdToProject < ActiveRecord::Migration
  # Add column
  def self.up
    add_column :projects, :lifecycle_id, :integer
  end

  # Remove column
  def self.down
    remove_column :projects, :lifecycle_id
  end
end
