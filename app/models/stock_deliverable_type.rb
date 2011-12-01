# StockDeliverableType represents a join tables that make it possible to
# establish a many-to-many relationship between DeliverableType and
# ProjectPhase

class StockDeliverableType < ActiveRecord::Base

  belongs_to :project_phase
  belongs_to :deliverable_type

  has_many :deliverables, :as => :assignable

  validates :deliverable_type_id, :presence => true
  validates :project_phase_id, :presence => true

  # return all the deliverable type records that are of the same deliverable type as the given record
  def get_same_stock_deliverable_types
    StockDeliverableType.find_all_by_deliverable_type_id(self.deliverable_type_id)
  end

  # return the StockDeliverableType deliverable with minimum estimated effort
  # for the given complexity_id
  def get_del_with_min_effort(complexity_id)
    c_dels = []    
    del_types = self.get_same_stock_deliverable_types
    
    del_types.each do |type|
      c_dels += type.deliverables.find_all_by_complexity_id(complexity_id,
                                                           :order => "estimated_effort asc",
                                                           :limit => 1) unless type.deliverables.nil?
    end
    c_dels.sort! {|a, b| a.estimated_effort <=> b.estimated_effort}
    c_dels.first unless c_dels.nil?
  end

  # return the StockDeliverableType deliverable with maximum estimated effort
  # for the given complexity_id
  def get_del_with_max_effort(complexity_id)
    c_dels = []    
    del_types = self.get_same_stock_deliverable_types
    
    del_types.each do |type|
      c_dels += type.deliverables.find_all_by_complexity_id(complexity_id,
                                                         :order => "estimated_effort desc",
                                                         :limit => 1) unless type.deliverables.nil?
    end
    c_dels.sort! {|a, b| a.estimated_effort <=> b.estimated_effort}
    c_dels.first unless c_dels.nil?
  end

  # return the StockDeliverableType deliverable with average estimated effort
  # for the given complexity_id
  def get_del_with_avg_effort(complexity_id)
    c_dels = []
    del_types = self.get_same_stock_deliverable_types
    
    del_types.each do |type|
      c_dels += type.deliverables.find_all_by_complexity_id(complexity_id,
                                                           :order => "estimated_effort asc") unless type.deliverables.nil?
    end
    c_dels.sort! {|a, b| a.estimated_effort <=> b.estimated_effort}
    if !c_dels.nil?
      cnt = c_dels.count
      if cnt
        median = (cnt / 2.0).ceil
        if median > 0
          return c_dels[median-1]
        end
      end
    end
  end
end
