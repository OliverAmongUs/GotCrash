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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_11_054313) do

  create_table "auto_parts", force: :cascade do |t|
    t.string "field"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bids", force: :cascade do |t|
    t.integer "fixer_id"
    t.integer "report_id"
    t.integer "privacy"
    t.string "description"
    t.float "cost"
    t.integer "marked"
    t.integer "ignored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.integer "owner_id"
    t.string "make"
    t.string "model"
    t.string "year"
    t.string "color"
    t.string "vin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "licence"
    t.string "picture_url"
    t.string "vehicle_type"
    t.string "body_class"
    t.integer "doors"
    t.string "gross_vehicle_weight_rating"
    t.string "transmission_style"
    t.string "engine_number_of_cylinders"
    t.string "engine_power"
    t.string "fuel_type"
  end

  create_table "fixer_join_autos", force: :cascade do |t|
    t.integer "fixer_id"
    t.integer "auto_part_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foreign_users", force: :cascade do |t|
    t.integer "user_id"
    t.float "average_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "body"
    t.integer "user_id"
    t.integer "bid_id"
    t.string "picture_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bid_id"
    t.integer "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "report_join_autos", force: :cascade do |t|
    t.integer "report_id"
    t.integer "auto_part_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "owner_id"
    t.integer "car_id"
    t.integer "completed"
    t.string "address"
    t.string "description"
    t.integer "privacy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_url"
    t.float "longitude"
    t.float "latitude"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "fixer_id"
    t.float "rating"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "report_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "phone"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "picture_url"
  end

end
