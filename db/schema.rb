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

ActiveRecord::Schema.define(:version => 20120715002052) do

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "times_viewed"
    t.decimal  "rating"
    t.date     "created_at",      :null => false
    t.integer  "category"
    t.boolean  "privacy"
    t.integer  "width"
    t.integer  "height"
    t.integer  "votes_count"
    t.integer  "favorites_count"
    t.integer  "comments_count"
    t.boolean  "nsfw"
    t.string   "image_url"
    t.integer  "user_id"
    t.datetime "updated_at",      :null => false
  end

end
