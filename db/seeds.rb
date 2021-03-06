puts "Deleting tables..."
Lifecycle.delete_all
LifecyclePhase.delete_all
DeliverableType.delete_all
Complexity.delete_all
Role.delete_all

puts "Creating roles..."
admin_role        = Role.create(:name => "admin")
regular_user_role = Role.create(:name => "regular_user")

puts "Creating admin users..."
unless User.find_by_email 'admin@admin.com'
  admin_user = User.create(
    :email                 => 'admin@admin.com',
    :password              => 'administrator',
    :password_confirmation => 'administrator'
  ) 

  # Assign the admin user role to the admin user
  admin_user.roles = [admin_role]
  admin_user.save!
end

puts "Creating ndss users"
unless User.find_by_email 'theadmin@ndss.com'
  admin_user = User.create(
    :email                 => 'theadmin@ndss.com',
    :password              => 'testme',
    :password_confirmation => 'testme'
  ) 

  # Assign the admin user role to the admin user
  admin_user.roles = [admin_role]
  admin_user.save!
end

unless User.find_by_email 'theboss@ndss.com'
  admin_user = User.create(
    :email                 => 'theboss@ndss.com',
    :password              => 'testme',
    :password_confirmation => 'testme'
  ) 
end

unless User.find_by_email 'sally@ndss.com'
  admin_user = User.create(
    :email                 => 'sally@ndss.com',
    :password              => 'testme',
    :password_confirmation => 'testme'
  ) 
end

unless User.find_by_email 'codemonkey@ndss.com'
  admin_user = User.create(
    :email                 => 'codemonkey@ndss.com',
    :password              => 'testme',
    :password_confirmation => 'testme'
  ) 
end

puts "Creating complexity..."
Complexity.create(:level => "low")
Complexity.create(:level => "medium")
Complexity.create(:level => "high")

puts "Creating lifecycles..."
lifecycle_1 = Lifecycle.create(:name => "Simplified Waterfall", :description => "This is a simplified version of the waterfall method")
lifecycle_2 = Lifecycle.create(:name => "Rational Unified Process", :description => "This is a rational unified process method")

puts "Creating lifecycle phases..."
requirements   = LifecyclePhase.create(:name => "Requirements",   
                                       :description => "What do we want to do? Does it make sense for the Organization to do it?", 
                                       :lifecycle_id => lifecycle_1.id, 
                                       :sequence_number => 1)
design         = LifecyclePhase.create(:name => "Design",         
                                       :description => "How are we going to do it? Who is going to do what? How long will it take? What will it cost?", 
                                       :lifecycle_id => lifecycle_1.id, 
                                       :sequence_number => 2)
implementation = LifecyclePhase.create(:name => "Implementation", 
                                       :description => "Are we doing what we agreed to do, and are we doing it right?", 
                                       :lifecycle_id => lifecycle_1.id, 
                                       :sequence_number => 3)
integration    = LifecyclePhase.create(:name => "Integration",    
                                       :description => "Can we put all the building blocks together?", 
                                       :lifecycle_id => lifecycle_1.id, 
                                       :sequence_number => 4)
verification   = LifecyclePhase.create(:name => "Verification",   
                                       :description => "Does it do what we expect it to do?", 
                                       :lifecycle_id => lifecycle_1.id, 
                                       :sequence_number => 5)
maintenance    = LifecyclePhase.create(:name => "Maintenance",    
                                       :description => "Are we able to support what we have done?", 
                                       :lifecycle_id => lifecycle_1.id, 
                                       :sequence_number => 6)
         
inception      = LifecyclePhase.create(:name => "Inception",     
                                       :description => "What are the project's objectives? How much will it cost? How long will it take?", 
                                       :lifecycle_id => lifecycle_2.id, 
                                       :sequence_number => 1)
elaboration    = LifecyclePhase.create(:name => "Elaboration",   
                                       :description => "How are we going to make this project successful? What are the roadblocks?", 
                                       :lifecycle_id => lifecycle_2.id, 
                                       :sequence_number => 2)
construction   = LifecyclePhase.create(:name => "Construction",  
                                       :description => "Are we doing what we agreed to do, and are we doing it right?", 
                                       :lifecycle_id => lifecycle_2.id, 
                                       :sequence_number => 3)
transition     = LifecyclePhase.create(:name => "Transition",    
                                       :description => "What do we need to do to deliver this project to our customers?", 
                                       :lifecycle_id => lifecycle_2.id, 
                                       :sequence_number => 4)

puts "Creating units of measure..."
pages          = UnitOfMeasure.create(:unit => "pages")
mockups        = UnitOfMeasure.create(:unit => "mockups")
use_cases      = UnitOfMeasure.create(:unit => "use cases")
diagrams       = UnitOfMeasure.create(:unit => "diagrams")
tests          = UnitOfMeasure.create(:unit => "tests")
lines_of_code  = UnitOfMeasure.create(:unit => "lines of code")


puts "Creating deliverable types..."
DeliverableType.create(:name => "Functional Requirements Document",
                       :lifecycle_phase_id => requirements.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Test and Evaluation Master Plan",
                       :lifecycle_phase_id => requirements.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Interface Control Document",
                       :lifecycle_phase_id => requirements.id,
                       :unit_of_measure_id => pages.id)

DeliverableType.create(:name => "Security Risk Assessment",
                       :lifecycle_phase_id => design.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Conversion Plan",
                       :lifecycle_phase_id => design.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "System Design Document",
                       :lifecycle_phase_id => design.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Implementation Plan",
                       :lifecycle_phase_id => design.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Operations Manual",
                       :lifecycle_phase_id => design.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "User Manual",
                       :lifecycle_phase_id => design.id,
                       :unit_of_measure_id => pages.id)

DeliverableType.create(:name => "Change Implementation Notice",
                       :lifecycle_phase_id => implementation.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Version Description Document",
                       :lifecycle_phase_id => implementation.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Post Implementation Review",
                       :lifecycle_phase_id => implementation.id,
                       :unit_of_measure_id => pages.id)

DeliverableType.create(:name => "Test Analysis Report",
                       :lifecycle_phase_id => integration.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Test Problem Report",
                       :lifecycle_phase_id => integration.id,
                       :unit_of_measure_id => pages.id)

DeliverableType.create(:name => "Verification and Validation Plan",
                       :lifecycle_phase_id => verification.id,
                       :unit_of_measure_id => pages.id)

DeliverableType.create(:name => "In-Process Review Report",
                       :lifecycle_phase_id => maintenance.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "User Satisfaction Report",
                       :lifecycle_phase_id => maintenance.id,
                       :unit_of_measure_id => pages.id)

DeliverableType.create(:name => "Business Case",
                       :lifecycle_phase_id => inception.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Project Scope",
                       :lifecycle_phase_id => inception.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Business Use-Case Model",
                       :lifecycle_phase_id => inception.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Candidate Architecture",
                       :lifecycle_phase_id => inception.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Risk Management Plan",
                       :lifecycle_phase_id => inception.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Project Schedule",
                       :lifecycle_phase_id => inception.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Cost Estimate",
                       :lifecycle_phase_id => inception.id,
                       :unit_of_measure_id => pages.id)

DeliverableType.create(:name => "Use Case Diagrams",
                       :lifecycle_phase_id => elaboration.id,
                       :unit_of_measure_id => diagrams.id)
DeliverableType.create(:name => "Conceptual Diagrams",
                       :lifecycle_phase_id => elaboration.id,
                       :unit_of_measure_id => diagrams.id)
DeliverableType.create(:name => "Architectural Diagrams",
                       :lifecycle_phase_id => elaboration.id,
                       :unit_of_measure_id => diagrams.id)
DeliverableType.create(:name => "Executable architecture",
                       :lifecycle_phase_id => elaboration.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Construction Plan",
                       :lifecycle_phase_id => elaboration.id,
                       :unit_of_measure_id => pages.id)

DeliverableType.create(:name => "Use Cases",
                       :lifecycle_phase_id => construction.id,
                       :unit_of_measure_id => use_cases.id)
DeliverableType.create(:name => "Activity Diagram",
                       :lifecycle_phase_id => construction.id,
                       :unit_of_measure_id => diagrams.id)
DeliverableType.create(:name => "Sequence Diagram",
                       :lifecycle_phase_id => construction.id,
                       :unit_of_measure_id => diagrams.id)
DeliverableType.create(:name => "Collaboration Diagram",
                       :lifecycle_phase_id => construction.id,
                       :unit_of_measure_id => diagrams.id)
DeliverableType.create(:name => "State Diagram",
                       :lifecycle_phase_id => construction.id,
                       :unit_of_measure_id => diagrams.id)
DeliverableType.create(:name => "Interaction Overview Diagram",
                       :lifecycle_phase_id => construction.id,
                       :unit_of_measure_id => diagrams.id)

DeliverableType.create(:name => "Deployment Plan",
                       :lifecycle_phase_id => transition.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "Customer Feedback",
                       :lifecycle_phase_id => transition.id,
                       :unit_of_measure_id => pages.id)
DeliverableType.create(:name => "User Manual",
                       :lifecycle_phase_id => transition.id,
                       :unit_of_measure_id => pages.id)

puts "Seed complete!"
