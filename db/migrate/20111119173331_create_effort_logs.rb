class CreateEffortLogs < ActiveRecord::Migration
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

  def self.down
    drop_table :effort_logs
  end
end
