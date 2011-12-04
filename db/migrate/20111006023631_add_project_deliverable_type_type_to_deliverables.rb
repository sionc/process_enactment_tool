# Migration for adding project deliverable type type to deliverables

class AddProjectDeliverableTypeTypeToDeliverables < ActiveRecord::Migration
  # Add column
  def self.up
    add_column :deliverables, :project_deliverable_type_type, :string
  end

  # Remove column
  def self.down
    remove_column :deliverables, :project_deliverable_type_type
  end
end
