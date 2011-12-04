# Migration for creating project phases

class CreateProjectPhases < ActiveRecord::Migration
  # Add table
  def self.up
    create_table :project_phases do |t|
      t.integer :project_id
      t.integer :lifecycle_phase_id

      t.timestamps
    end
  end

  # Drop table
  def self.down
    drop_table :project_phases
  end
end
