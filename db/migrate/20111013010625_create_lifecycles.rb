# Migration for creating lifecycles
class CreateLifecycles < ActiveRecord::Migration
  # Add table
  def self.up
    create_table :lifecycles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  # Drop table
  def self.down
    drop_table :lifecycles
  end
end
