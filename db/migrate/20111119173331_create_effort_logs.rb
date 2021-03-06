# Migration for creating effort logs

class CreateEffortLogs < ActiveRecord::Migration
  # Add table
  def self.up
    create_table :effort_logs do |t|
      t.datetime :start_date_time
      t.datetime :stop_date_time
      t.integer :interrupt_time
      t.text :comment
      t.integer :user_id
      t.integer :deliverable_id

      t.timestamps
    end
  end

  # Drop table
  def self.down
    drop_table :effort_logs
  end
end
