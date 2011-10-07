class AddProjectDeliverableTypeTypeToDeliverables < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :project_deliverable_type_type, :string
  end

  def self.down
    remove_column :deliverables, :project_deliverable_type_type
  end
end
