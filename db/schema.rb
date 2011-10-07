# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111006023631) do

  create_table "deliverable_types", :force => true do |t|
    t.string   "name"
    t.integer  "unit_of_measure_id"
    t.integer  "lifecycle_phase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deliverables", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "estimated_size"
    t.float    "estimated_production_rate"
    t.float    "estimated_effort"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_deliverable_type_id"
    t.string   "project_deliverable_type_type"
  end

  create_table "lifecycle_phases", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "sequence_number"
    t.integer  "lifecycle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lifecycles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_phases", :force => true do |t|
    t.integer  "project_id"
    t.integer  "lifecycle_phase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lifecycle_id"
  end

  create_table "stock_deliverable_types", :force => true do |t|
    t.integer  "project_phase_id"
    t.integer  "deliverable_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
