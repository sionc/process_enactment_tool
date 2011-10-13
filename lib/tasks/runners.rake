require 'rubygems'

namespace :sneakers do

  desc "run everything on localhost -- only run this if you want demo data - you will lose all existing data"
  task :run_local => :environment do
    puts "Resetting the DB"
  	Rake::Task['db:migrate:reset'].invoke
  	puts "Seeding the database"
  	Rake::Task['db:seed'].invoke
  	puts "Loading Demo Data"
  	Rake::Task['db:load_demo_data'].invoke
  end
  
  desc "run everything on heroku -- only run this if you want demo data - you will lose all existing data"
  task :run_heroku do    
    puts "Resetting Database... "
    sh %{heroku pg:reset SHARED_DATABASE --confirm gentle-flower-5712}
    puts "Migrating database... "
    sh %{heroku rake db:migrate}
    puts "Seeding Database... "
    sh %{heroku rake db:seed}
    puts "Loading Demo Data... "
    sh %{heroku rake db:load_demo_data}
    puts "Heroku Demo Data Loaded!"
  end
  
end