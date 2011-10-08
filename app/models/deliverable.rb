class Deliverable < ActiveRecord::Base

  belongs_to :assignable, :polymorphic => true

  validates :name, :presence => true
  validates :assignable_id, :presence => true
  validates :assignable_type, :presence => true
  
  # attr_accessor :stock_deliverable_type_id
end
