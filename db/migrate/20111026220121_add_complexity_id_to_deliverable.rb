class AddComplexityIdToDeliverable < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :complexity_id, :integer
  end

  def self.down
    remove_column :deliverables, :complexity_id
  end
end
