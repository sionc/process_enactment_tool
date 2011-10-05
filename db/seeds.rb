# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Lifecycle.delete_all
LifecyclePhase.delete_all

# ActiveRecord::Base.connection.execute("TRUNCATE table lifecycles") 
# ActiveRecord::Base.connection.execute("TRUNCATE table lifecycle_phases") 

# sql = "INSERT INTO lifecycles ('name', 'description') 
#        VALUES ('Simplified Waterfall', 'This is a simplified version of the waterfall method'),
#               ('Rational Unified Process', 'This is a rational unified process method');"

lifecycle_1 = Lifecycle.create(:name => "Simplified Waterfall", :description => "This is a simplified version of the waterfall method")
lifecycle_2 = Lifecycle.create(:name => "Rational Unified Process", :description => "This is a rational unified process method")

LifecyclePhase.create(:name => "Requirements",   :description => "", :lifecycle_id => lifecycle_1.id, :sequence_number => 1)
LifecyclePhase.create(:name => "Design",         :description => "", :lifecycle_id => lifecycle_1.id, :sequence_number => 2)
LifecyclePhase.create(:name => "Implementation", :description => "", :lifecycle_id => lifecycle_1.id, :sequence_number => 3)
LifecyclePhase.create(:name => "Integration",    :description => "", :lifecycle_id => lifecycle_1.id, :sequence_number => 4)
LifecyclePhase.create(:name => "Verification",   :description => "", :lifecycle_id => lifecycle_1.id, :sequence_number => 5)
LifecyclePhase.create(:name => "Maintenance",    :description => "", :lifecycle_id => lifecycle_1.id, :sequence_number => 6)
       
LifecyclePhase.create(:name => "Inception",     :description => "", :lifecycle_id => lifecycle_2.id, :sequence_number => 1)
LifecyclePhase.create(:name => "Elaboration",   :description => "", :lifecycle_id => lifecycle_2.id, :sequence_number => 2)
LifecyclePhase.create(:name => "Construction",  :description => "", :lifecycle_id => lifecycle_2.id, :sequence_number => 3)
LifecyclePhase.create(:name => "Transition",    :description => "", :lifecycle_id => lifecycle_2.id, :sequence_number => 4)
# ActiveRecord::Base.connection.execute(sql)