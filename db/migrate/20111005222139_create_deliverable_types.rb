# Migration for creating deliverable types

class CreateDeliverableTypes < ActiveRecord::Migration
  # Add table
  def self.up
    create_table :deliverable_types do |t|
      t.string :name
      t.integer :unit_of_measure_id
      t.integer :lifecycle_phase_id

      t.timestamps
    end
  end

  # Drop table
  def self.down
    drop_table :deliverable_types
  end
end
