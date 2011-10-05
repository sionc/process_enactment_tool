# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Lifecycle.delete_all
# ActiveRecord::Base.connection.execute("TRUNCATE table lifecycles") 
# ActiveRecord::Base.connection.execute("TRUNCATE table lifecycle_phases") 

# sql = "INSERT INTO lifecycles ('name', 'description') 
#        VALUES ('Simplified Waterfall', 'This is a simplified version of the waterfall method'),
#               ('Rational Unified Process', 'This is a rational unified process method');"

Lifecycle.create(:name => "Simplified Waterfall", :description => "This is a simplified version of the waterfall method")
Lifecycle.create(:name => "Rational Unified Process", :description => "This is a rational unified process method")
       
# ActiveRecord::Base.connection.execute(sql)

       