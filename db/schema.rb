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

ActiveRecord::Schema.define(:version => 20120415235157) do

  create_table "list_items", :force => true do |t|
    t.string   "word"
    t.text     "sentence"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "word_order"
    t.integer  "word_list_id"
  end

  create_table "practice_sessions", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "user_id"
    t.integer  "word_list_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

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

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "user_guid"
  end

  create_table "word_lists", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "due_date"
    t.string   "title"
  end

end
