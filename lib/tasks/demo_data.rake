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
                               :assignable_type => "StockDeliverableType")

          end
        end      
      end      
    end
  end
end
