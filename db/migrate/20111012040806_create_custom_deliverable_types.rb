class CreateCustomDeliverableTypes < ActiveRecord::Migration
  def self.up
    create_table :custom_deliverable_types do |t|
      t.integer :project_phase_id
      t.string :name
      t.integer :unit_of_measure_id

      t.timestamps
    end
  end

  def self.down
    drop_table :custom_deliverable_types
  end
end
