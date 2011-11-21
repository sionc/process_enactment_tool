class EffortLog < ActiveRecord::Base
  belongs_to :deliverable

  #validates :start_date_time, :presence => true
  #validates :stop_date_time, :presence => true
  #validates :deliverable_id, :presence => true

  #def total_effort
  #   unless self.start_date_time.nil? && self.stop_date_time.nil?
  #     unless self.interrupt_time.nil?
  #       self.stop_date_time - self.start_date_time - self.interrupt_time
  #     end
  #     self.stop_date_time - self.start_date_time
  #   end
  #end

end
