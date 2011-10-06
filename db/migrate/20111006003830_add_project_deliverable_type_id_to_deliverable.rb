class AddProjectDeliverableTypeIdToDeliverable < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :project_deliverable_type_id, :integer
  end

  def self.down
    remove_column :deliverables, :project_deliverable_type_id
  end
end
