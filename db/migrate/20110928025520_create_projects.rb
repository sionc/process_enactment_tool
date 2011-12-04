# Migration for creating projects

class CreateProjects < ActiveRecord::Migration
  # Add table
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  # Drop table
  def self.down
    drop_table :projects
  end
end
