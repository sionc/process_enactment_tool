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

Factory.define :unit_of_measure do |uom|
  uom.unit                  "pages"
end

Factory.define :deliverable_type do |type|
  type.name                 "Requirements Document"
  type.association          :lifecycle_phase
  type.association          :unit_of_measure
 end

Factory.define :stock_deliverable_type do |type|
  type.association          :project_phase
  type.association          :deliverable_type
end

Factory.define :custom_deliverable_type do |type|
  type.name                 "Custom Document"
  type.association          :project_phase
  type.association          :unit_of_measure
end

Factory.define :complexity do |c|
  c.level                    "low"
end

# This deliverable is not associated with a assignable_type
# Currently, the assignable_type and assignable_id are hard coded
Factory.define :deliverable do |stk_del|
  stk_del.name                            "Stock Deliverable"
  stk_del.description                     "This is the description of the stock deliverable"
  stk_del.estimated_size                  1
  stk_del.estimated_production_rate       2.5
  stk_del.estimated_effort                2.5
  stk_del.assignable_id                   1
  stk_del.assignable_type                 "StockDeliverableType"
  stk_del.complexity_id                   1
end

Factory.define :effort_log do |log|
  log.start_date_time   "2011-11-19 09:33:31"
  log.stop_date_time    "2011-11-19 11:33:31"
  log.interrupt_time    15
  log.comment           "MyText"
  log.user_id           1
  log.association       :deliverable
end

Factory.define :role do |role|
  role.name                               "regular_user"
end

Factory.define :admin_role, :parent => :role do |role|
  role.name                               "admin"
end

Factory.define :user do |user|
  user.email                              "test@test.com"
  user.password                           "testme"
  user.password_confirmation              "testme"
end

Factory.define :admin_user, :parent => :user do |user|
  user.email                              "admin@admin.com"
  user.password                           "administrator"
  user.password_confirmation              "administrator"
end