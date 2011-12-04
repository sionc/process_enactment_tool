# Migration for creating unit of measure

class CreateUnitOfMeasures < ActiveRecord::Migration
  # Add table
  def self.up
    create_table :unit_of_measures do |t|
      t.string :unit

      t.timestamps
    end
  end

  # Drop table
  def self.down
    drop_table :unit_of_measures
  end
end
