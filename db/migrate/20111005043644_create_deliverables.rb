class CreateDeliverables < ActiveRecord::Migration
  def self.up
    create_table :deliverables do |t|
      t.string :name
      t.text :description
      t.float :estimated_size
      t.float :estimated_production_rate
      t.float :estimated_effort

      t.timestamps
    end
  end

  def self.down
    drop_table :deliverables
  end
end
