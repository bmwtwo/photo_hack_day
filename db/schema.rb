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

ActiveRecord::Schema.define(:version => 20120715014039) do

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "camera"
    t.string   "lens"
    t.string   "aperture"
    t.integer  "times_viewed"
    t.decimal  "rating"
    t.integer  "status"
    t.date     "created_at",          :null => false
    t.integer  "category"
    t.string   "location"
    t.boolean  "privacy"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.date     "taken_at"
    t.boolean  "hi_res_uploaded"
    t.boolean  "for_sale"
    t.integer  "width"
    t.integer  "height"
    t.integer  "votes_count"
    t.integer  "favorites_count"
    t.integer  "comments_count"
    t.boolean  "nsfw"
    t.integer  "sales_count"
    t.date     "for_sale_date"
    t.decimal  "highest_rating"
    t.date     "highest_rating_date"
    t.string   "image_url"
    t.boolean  "store_download"
    t.boolean  "store_print"
    t.datetime "updated_at",          :null => false
    t.string   "iso"
    t.string   "focal_length"
    t.string   "shutter_speed"
  end

end
