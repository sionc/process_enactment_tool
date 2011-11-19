require 'rubygems'

namespace :db do

  desc "Load demo data for demos"
  task :load_demo_data => :environment do
    
    # Find our lifecycles
    waterfall = Lifecycle.find_by_name("Simplified Waterfall")
    rup       = Lifecycle.find_by_name("Rational Unified Process")
    
    # Create a few projects    
    waterfall_project = Project.create(:name => "Gentle Flower", 
                              :description => "This project helps to track endangered species of flowers", 
                              :lifecycle_id => waterfall.id)
    
    rup_project = Project.create(:name => "Newtons Cradle", 
                              :description => "A project to manage the building of the world's largest Newton Cradle", 
                              :lifecycle_id => rup.id)
    
    # Fill in associated lifecycle phases for the projects
    waterfall_project.lifecycle_phases  = Lifecycle.find_by_id(waterfall_project.lifecycle_id).lifecycle_phases
    rup_project.lifecycle_phases        = Lifecycle.find_by_id(rup_project.lifecycle_id).lifecycle_phases
    
    # Associate deliverable types for waterfall project.
    waterfall_project.project_phases.each do |proj_phase|
      proj_phase.deliverable_types = LifecyclePhase.find(proj_phase.lifecycle_phase_id).deliverable_types
    end
    
    # Associate deliverable types for rup project.
    rup_project.project_phases.each do |proj_phase|
      proj_phase.deliverable_types = LifecyclePhase.find(proj_phase.lifecycle_phase_id).deliverable_types
    end
    
    
    # Find all phases
    waterfall_phases  = waterfall.lifecycle_phases
    rup_phases        = rup.lifecycle_phases
           
    # Iterate through phases, deliverable types, and stock deliverable types to generate deliverables
    (waterfall_phases | rup_phases).each do |phase|
      phase.deliverable_types.each do |dType|      
        dType.stock_deliverable_types.each do |sdt|
          
          # Loop twice to build two deliverables for each stock deliverable type
          (1..2).each do |num|
            estimated_size = (1+rand(19)) / 2.0
            estimated_production_rate = (1+rand(19)) / 2.0
            Deliverable.create(:name => "#{dType.name} #{num}", 
                               :description => "#{dType.name} #{num} description - isn't this fun!",
                               :estimated_size => estimated_size,
                               :estimated_production_rate => estimated_production_rate,
                               :estimated_effort => estimated_size * estimated_production_rate,
                               :assignable_id => sdt.id,
                               :assignable_type => "StockDeliverableType",
                               :complexity_id => Complexity.first)

          end
        end      
      end      
    end
  end
  
  desc "Load test data"
  task :seed_test_data => :environment do
    
    # Find our lifecycles
    waterfall = Lifecycle.find_by_name("Simplified Waterfall")
    rup       = Lifecycle.find_by_name("Rational Unified Process")
    
    # Create a few projects    
    waterfall_project = Project.create(:name => "Test Gentle Flower", 
                              :description => "This project helps to track endangered species of flowers", 
                              :lifecycle_id => waterfall.id)
    
    rup_project = Project.create(:name => "Test Newtons Cradle", 
                              :description => "A project to manage the building of the world's largest Newton Cradle", 
                              :lifecycle_id => rup.id)
    
    # Fill in associated lifecycle phases for the projects
    waterfall_project.lifecycle_phases  = Lifecycle.find_by_id(waterfall_project.lifecycle_id).lifecycle_phases
    rup_project.lifecycle_phases        = Lifecycle.find_by_id(rup_project.lifecycle_id).lifecycle_phases
    
    # Associate deliverable types for waterfall project.
    waterfall_project.project_phases.each do |proj_phase|
      proj_phase.deliverable_types = LifecyclePhase.find(proj_phase.lifecycle_phase_id).deliverable_types
    end
    
    # Associate deliverable types for rup project.
    rup_project.project_phases.each do |proj_phase|
      proj_phase.deliverable_types = LifecyclePhase.find(proj_phase.lifecycle_phase_id).deliverable_types
    end
    
    
    # Find all phases
    waterfall_phases  = waterfall.lifecycle_phases
    rup_phases        = rup.lifecycle_phases
           
    # Iterate through phases, deliverable types, and stock deliverable types to generate deliverables
    (waterfall_phases | rup_phases).each do |phase|
      phase.deliverable_types.each do |dType|      
        dType.stock_deliverable_types.each do |sdt|
          
          estimates = [2, 4, 6, 8]
          # Loop through each complexity
          Complexity.all.each do |test_complexity|
            # Loop four times to build four deliverables for each stock deliverable type
            (1..4).each_with_index do |num, index|
            
              # predictable set of numbers for each deliverable size
              # [deliverable 1 (size = 2), 
              # deliverable 2 (size = 8), 
              # deliverable 3 (size = 18),
              # deliverable 4 (size = 32)]
              estimated_size = estimates[index].to_f * num
            
              # predictable set of numbers for each deliverable rate
              # [deliverable 1 (rate = 3), 
              # deliverable 2 (rate = 24), 
              # deliverable 3 (rate = 54),
              # deliverable 4 (rate = 96)]
              estimated_production_rate = estimates[index].to_f * num * 3.0
            
            
              # predictable set of numbers for deliverable effort
              # [deliverable 1 (effort = 6), 
              # deliverable 2 (effort = 192), 
              # deliverable 3 (effort = 972),
              # deliverable 4 (effort = 3072)]
            
              Deliverable.create(:name => "#{dType.name} #{num}", 
                                 :description => "#{dType.name} #{num} description - isn't this fun!",
                                 :estimated_size => estimated_size,
                                 :estimated_production_rate => estimated_production_rate,
                                 :estimated_effort => estimated_size * estimated_production_rate,
                                 :assignable_id => sdt.id,
                                 :assignable_type => "StockDeliverableType",
                                 :complexity_id => test_complexity.id)

            end
          end  
        end    
      end      
    end
  end
  
  
end
