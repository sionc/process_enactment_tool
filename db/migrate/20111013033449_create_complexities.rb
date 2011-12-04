# Migration for creating complexities

class CreateComplexities < ActiveRecord::Migration
  # Add table
  def self.up
    create_table :complexities do |t|
      t.string :level

      t.timestamps
    end
  end

  # Drop table
  def self.down
    drop_table :complexities
  end
end
