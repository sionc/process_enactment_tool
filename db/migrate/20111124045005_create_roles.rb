# Migration for creating roles
class CreateRoles < ActiveRecord::Migration
  # Add table
  def self.up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
  end

  # Drop table
  def self.down
    drop_table :roles
  end
end
