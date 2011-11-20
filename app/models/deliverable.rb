# This model represents the deliverables created by the user. They are
# associated with a stock deliverable type or a custom deliverable type
# through the polymorphic association: belongs_to :assignable, :polymorphic => true
#
# Deliverables have estimated effort, estimated size, and estimated production
# rate attributes that must have this relationship:
# estimated_effort = estimated_size * estimated_production_rate

class Deliverable < ActiveRecord::Base

  has_many :effort_logs

  belongs_to :assignable, :polymorphic => true
  belongs_to :complexity

  validates :name, :presence => true
  validates :assignable_id, :presence => true
  validates :assignable_type, :presence => true

  validates :estimated_effort, :presence => true, :numericality => {:greater_than =>  0}
  validates :estimated_size, :presence => true, :numericality => {:greater_than =>  0}
  validates :estimated_production_rate, :presence => true, :numericality => {:greater_than =>  0}

  validates :complexity_id, :presence => true
  
  validate :estimations_should_be_valid

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

  # Validates that the estimations are accurate and that size * production rate = effort
  def estimations_should_be_valid
    if (estimated_effort != (estimated_size.to_f * estimated_production_rate.to_f))
      errors.add(:estimated_size, "must be equal to estimated effort / estimated production rate")
      errors.add(:estimated_production_rate, "must be equal to estimated effort / estimated size")
      errors.add(:estimated_effort, "must be equal to estimated size * estimated production rate")
    end
  end

end
