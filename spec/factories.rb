Factory.define :lifecycle do |lifecycle|
  lifecycle.name            "Waterfall"
  lifecycle.description     "This is the description"
end

Factory.define :project do |project|
  project.name              "Project"
  project.description       "This is the description"
  project.association       :lifecycle
end

Factory.define :lifecycle_phase do |phase|
  phase.name                "Lifecycle Phase"
  phase.description         "This is the description"
  phase.sequence_number     1
  phase.association         :lifecycle
end

Factory.define :project_phase do |phase|
  phase.association         :project
  phase.association         :lifecycle_phase
end

Factory.define :deliverable_type do |type|
  type.name                 "Requirements Document"
  type.association          :lifecycle_phase
 end

Factory.define :stock_deliverable_type do |type|
  type.association          :project_phase
  type.association          :deliverable_type
end