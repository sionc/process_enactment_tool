# Migration for modifying polymorphic details columns in deliverables
# Replace project_deliverable_type_id with assignable_id
# and replace project_deliverable_type_type with assignable_type

class ChangePolymorphicDetailsInDeliverables < ActiveRecord::Migration
  # Replace columns
  def self.up
    remove_column :deliverables, :project_deliverable_type_id
    remove_column :deliverables, :project_deliverable_type_type

    add_column :deliverables, :assignable_id, :integer
    add_column :deliverables, :assignable_type, :string
  end

  # Undo replace columns
  def self.down
    remove_column :deliverables, :assignable_id
    remove_column :deliverables, :assignable_type

    add_column :deliverables, :project_deliverable_type_id, :integer
    add_column :deliverables, :project_deliverable_type_type, :string
  end
end
