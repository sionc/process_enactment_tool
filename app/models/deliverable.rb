class Deliverable < ActiveRecord::Base

  belongs_to :assignable, :polymorphic => true

  validates :name, :presence => true
  validates :assignable_id, :presence => true
  validates :assignable_type, :presence => true

  validates :estimated_effort, :presence => true, :numericality => {:greater_than =>  0}
  validates :estimated_size, :presence => true, :numericality => {:greater_than =>  0}
  validates :estimated_production_rate, :presence => true, :numericality => {:greater_than =>  0}

end
