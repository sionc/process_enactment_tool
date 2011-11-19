# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :effort_log do
    start_date_time "2011-11-19 09:33:31"
    stop_date_time "2011-11-19 09:33:31"
    interrupt_time 1
    comment "MyText"
    user_id 1
    deliverable_id 1
  end
end
