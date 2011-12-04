# Migration for creating stock deliverable types

class CreateStockDeliverableTypes < ActiveRecord::Migration
  # Add table
  def self.up
    create_table :stock_deliverable_types do |t|
      t.integer :project_phase_id
      t.integer :deliverable_type_id

      t.timestamps
    end
  end

  # Drop table
  def self.down
    drop_table :stock_deliverable_types
  end
end
