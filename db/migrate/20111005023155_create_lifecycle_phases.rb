# Migration for creating lifecycle phases

class CreateLifecyclePhases < ActiveRecord::Migration
  # Add table
  def self.up
    create_table :lifecycle_phases do |t|
      t.string :name
      t.text :description
      t.integer :sequence_number
      t.integer :lifecycle_id

      t.timestamps
    end
  end

  # Drop table
  def self.down
    drop_table :lifecycle_phases
  end
end
