class CreateStockDeliverableTypes < ActiveRecord::Migration
  def self.up
    create_table :stock_deliverable_types do |t|
      t.integer :project_phase_id
      t.integer :deliverable_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :stock_deliverable_types
  end
end
