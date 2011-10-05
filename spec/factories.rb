Factory.define :lifecycle do |lifecycle|
  lifecycle.name          "Waterfall"
  lifecycle.description   "This is the description"
end

Factory.define :project do |project|
  project.name            "Waterfall"
  project.description     "This is the description"
  project.association :lifecycle
end

Factory.define :lifecycle_phase do |phase|
  phase.name            "Waterfall"
  phase.description     "This is the description"
  phase.sequence_number 1
  phase.association     :lifecycle
  
end