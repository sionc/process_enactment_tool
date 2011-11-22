# A class to track the effort that is logged against a deliverable
class EffortLog < ActiveRecord::Base
  belongs_to :deliverable

  validate :start_date_time_format
  validate :stop_date_time_format

  validates :start_date_time, :presence => true
  validates :stop_date_time, :presence => true
  validates :deliverable_id, :presence => true

  # Return the number of hours that were logged, 
  # and taking in to account the interrupt time if there is any
  def logged_effort
    unless self.start_date_time.nil? && self.stop_date_time.nil?
      # Calculate the logged time
      time_logged = (self.stop_date_time - self.start_date_time) / 60
      unless self.interrupt_time.nil?        
        # return the number of hours that were logged minus the interrupt time
        time_logged = (time_logged - self.interrupt_time) / 60
      end
      # return the number of hours that were logged
      time_logged
    end
  end

  # Custom validator for checking the start_date_time format
  def start_date_time_format
    errors.add(:start_date_time, 'must be a valid datetime') if ((DateTime.parse(start_date_time.to_s) rescue ArgumentError) == ArgumentError)
  end

  # Custom validator for checking the stop_date_time format
  def stop_date_time_format
    errors.add(:stop_date_time, 'must be a valid datetime') if ((DateTime.parse(stop_date_time.to_s) rescue ArgumentError) == ArgumentError)
  end
end
