class CreateDeliverableTypes < ActiveRecord::Migration
  def self.up
    create_table :deliverable_types do |t|
      t.string :name
      t.integer :unit_of_measure_id
      t.integer :lifecycle_phase_id

      t.timestamps
    end
  end

  def self.down
    drop_table :deliverable_types
  end
end
