class Deliverable < ActiveRecord::Base

  belongs_to :assignable, :polymorphic => true
  belongs_to :complexity

  validates :name, :presence => true
  validates :assignable_id, :presence => true
  validates :assignable_type, :presence => true

  validates :estimated_effort, :presence => true, :numericality => {:greater_than =>  0}
  validates :estimated_size, :presence => true, :numericality => {:greater_than =>  0}
  validates :estimated_production_rate, :presence => true, :numericality => {:greater_than =>  0}

  validates :complexity_id, :presence => true

	# Return the name of the deliverable type associated with this deliverable
	def deliverable_type
		if assignable_type == "StockDeliverableType"
			StockDeliverableType.find(assignable_id).deliverable_type.name
		else
			CustomDeliverableType.find(assignable_id).name
		end
	end

  # Return the unit of measure associated with this deliverable
 	def unit_of_measure
    if assignable_type == "StockDeliverableType"
			stock_deliverable_type = StockDeliverableType.find(assignable_id)
      stock_deliverable_type.deliverable_type.unit_of_measure.unit
     else
			CustomDeliverableType.find(assignable_id).unit_of_measure.unit
		end
   end

  # Return the complexity level associated with this deliverable
 	def complexity_level
		complexity.level
  end

end
