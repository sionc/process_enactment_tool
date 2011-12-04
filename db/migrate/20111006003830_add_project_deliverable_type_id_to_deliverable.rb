# Migration for adding a project deliverable type id to a deliverable

class AddProjectDeliverableTypeIdToDeliverable < ActiveRecord::Migration
  # Add column
  def self.up
    add_column :deliverables, :project_deliverable_type_id, :integer
  end

  # Remove column
  def self.down
    remove_column :deliverables, :project_deliverable_type_id
  end
end
