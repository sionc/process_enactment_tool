# A class to track the effort that is logged against a deliverable
class EffortLog < ActiveRecord::Base
  belongs_to :deliverable
  belongs_to :user

  validate :start_date_time_format
  validate :stop_date_time_format
  validate :stop_date_is_not_before_start_date
  validate :stop_date_is_not_in_the_future
  validate :start_date_is_not_in_the_future
  validate :times_do_not_overlap
  validate :interrupt_time_value

  validates :start_date_time, :presence => true
  validates :stop_date_time, :presence => true
  validates :deliverable_id, :presence => true
  validates :user_id, :presence => true

  # Return the number of hours that were logged, 
  # and taking in to account the interrupt time if there is any
  def logged_effort
    unless self.start_date_time.nil? || self.stop_date_time.nil?
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

  # Custom validator for checking that stop date is not before start date
  def stop_date_is_not_before_start_date
    errors.add(:stop_date_time, 'must come after start time') if (start_date_time && stop_date_time && (start_date_time > stop_date_time))
  end

  # Custom validator for checking that stop date is not in the future
  def stop_date_is_not_in_the_future
    errors.add(:stop_date_time, 'must come on or before midnight') if (stop_date_time && (stop_date_time > DateTime.now.end_of_day ))    
  end

  # Custom validator for checking that stop date is not in the future
  def start_date_is_not_in_the_future
    errors.add(:start_date_time, 'must come on or before midnight') if (start_date_time && (start_date_time > DateTime.now.end_of_day ))    
  end

  # Determine whether or not the given effort log overlaps this one
  # To overlap, an effort log must begin before this one ends, and
  # end after this one starts
  def overlaps? (effort_log)
    return ((effort_log.start_date_time < self.stop_date_time) &&
            (effort_log.stop_date_time  > self.start_date_time) && 
            effort_log.user_id == self.user_id)
  end

  # Custom validator for checking whether effort log time entries overlap
  def times_do_not_overlap
    # If any effort log overlaps, add errors and return immediately
    EffortLog.all.each do |effort_log|
      if self.overlaps? (effort_log)
        errors.add(:start_date_time, 'must not overlap with existing effort log')
        errors.add(:stop_date_time,  'must not overlap with existing effort log')
        return
      end
    end
  end

  # Custom validator for checking that the interrupt time is >= logged time
  def interrupt_time_value
    unless self.start_date_time.nil? || self.stop_date_time.nil? || self.interrupt_time.nil?
      errors.add(:interrupt_time, 'must be less than logged time') if (interrupt_time >= (stop_date_time - start_date_time)/60)
    end
  end

end
