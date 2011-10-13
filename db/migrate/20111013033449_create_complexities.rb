class CreateComplexities < ActiveRecord::Migration
  def self.up
    create_table :complexities do |t|
      t.string :level

      t.timestamps
    end
  end

  def self.down
    drop_table :complexities
  end
end
