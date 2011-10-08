class ChangePolymorphicDetailsInDeliverables < ActiveRecord::Migration
  def self.up
    remove_column :deliverables, :project_deliverable_type_id
    remove_column :deliverables, :project_deliverable_type_type

    add_column :deliverables, :assignable_id, :integer
    add_column :deliverables, :assignable_type, :string
  end

  def self.down
    remove_column :deliverables, :assignable_id
    remove_column :deliverables, :assignable_type

    add_column :deliverables, :project_deliverable_type_id, :integer
    add_column :deliverables, :project_deliverable_type_type, :string
  end
end
