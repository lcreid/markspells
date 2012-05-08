# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120507050631) do

  create_table "assignments", :force => true do |t|
    t.integer  "assigned_by_id"
    t.integer  "assigned_to_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "word_list_id"
  end

  add_index "assignments", ["assigned_by_id"], :name => "index_assignments_on_assigned_by_id"
  add_index "assignments", ["assigned_to_id"], :name => "index_assignments_on_assigned_to_id"
  add_index "assignments", ["word_list_id"], :name => "index_assignments_on_word_list_id"

  create_table "child_parents", :force => true do |t|
    t.integer  "child_id"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "child_parents", ["child_id"], :name => "index_child_parents_on_child_id"
  add_index "child_parents", ["parent_id"], :name => "index_child_parents_on_parent_id"

  create_table "list_items", :force => true do |t|
    t.string   "word"
    t.text     "sentence"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "word_order"
    t.integer  "word_list_id"
  end

  add_index "list_items", ["word_list_id"], :name => "index_list_items_on_word_list_id"

  create_table "old_users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "user_guid"
  end

  create_table "practice_sessions", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "user_id"
    t.integer  "word_list_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "practice_sessions", ["user_id"], :name => "index_practice_sessions_on_user_id"
  add_index "practice_sessions", ["word_list_id"], :name => "index_practice_sessions_on_word_list_id"

  create_table "student_responses", :force => true do |t|
    t.string   "word"
    t.string   "student_response"
    t.text     "sentence"
    t.string   "action"
    t.boolean  "correct"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "word_id"
    t.integer  "user_id"
    t.integer  "practice_session_id"
    t.datetime "start_time"
    t.datetime "end_time"
  end

  add_index "student_responses", ["practice_session_id"], :name => "index_student_responses_on_practice_session_id"
  add_index "student_responses", ["user_id"], :name => "index_student_responses_on_user_id"
  add_index "student_responses", ["word_id"], :name => "index_student_responses_on_word_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "user_guid"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "word_lists", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "due_date"
    t.string   "title"
  end

end
