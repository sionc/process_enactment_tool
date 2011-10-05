class CreateProjectPhases < ActiveRecord::Migration
  def self.up
    create_table :project_phases do |t|
      t.integer :project_id
      t.integer :lifecycle_phase_id

      t.timestamps
    end
  end

  def self.down
    drop_table :project_phases
  end
end
