# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# ActiveRecord::Base.connection.execute("DELETE FROM lifecycles IF EXISTS") 
# ActiveRecord::Base.connection.execute("TRUNCATE table lifecycle_phases") 

sql = "INSERT INTO lifecycles ('name', 'description') 
       VALUES ('Simplified Waterfall', 'This is a simplified version of the waterfall method'),
              ('Rational Unified Process', 'This is a rational unified process method');"
       
ActiveRecord::Base.connection.execute(sql)

       