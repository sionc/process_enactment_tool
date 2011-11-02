class Deliverable < ActiveRecord::Base

  belongs_to :assignable, :polymorphic => true

  validates :name, :presence => true
  validates :assignable_id, :presence => true
  validates :assignable_type, :presence => true

  validates :estimated_effort, :presence => true, :numericality => {:greater_than =>  0}
  validates :estimated_size, :presence => true, :numericality => {:greater_than =>  0}
  validates :estimated_production_rate, :presence => true, :numericality => {:greater_than =>  0}

	# Return the name of the deliverable type associated with this deliverable
	def deliverable_type
		if assignable_type == "StockDeliverableType"
			StockDeliverableType.find(assignable_id).deliverable_type.name
		else
			CustomDeliverableType.find(assignable_id).name
		end
	end
	
end
