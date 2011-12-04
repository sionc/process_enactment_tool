# Migration for creating join table between users and roles

class UsersHaveAndBelongToManyRoles < ActiveRecord::Migration
  # Add table
  def self.up
    create_table :roles_users, :id => false do |t|
      t.references :role, :user
    end
  end

  # Drop table
  def self.down
    drop_table :roles_users
  end
end
