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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150128173427) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "gigs", force: :cascade do |t|
    t.string   "gig_title",          limit: 255
    t.string   "category",           limit: 255
    t.text     "description"
    t.integer  "duration"
    t.text     "video"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "subcategory_id"
    t.string   "status",             limit: 255
    t.integer  "view_count",                     default: 0, null: false
    t.integer  "category_id"
    t.string   "slug",               limit: 255
    t.string   "processing_time",    limit: 255
    t.boolean  "featured"
    t.string   "cover_file_name",    limit: 255
    t.string   "cover_content_type", limit: 255
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  add_index "gigs", ["slug"], name: "index_gigs_on_slug", unique: true

  create_table "images", force: :cascade do |t|
    t.integer  "gig_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "graphic_file_name",    limit: 255
    t.string   "graphic_content_type", limit: 255
    t.integer  "graphic_file_size"
    t.datetime "graphic_updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "address_one",         limit: 255
    t.string   "address_two",         limit: 255
    t.string   "email",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gig_id"
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.string   "state",               limit: 255
    t.string   "country",             limit: 255
    t.string   "zipcode",             limit: 255
    t.text     "remark"
    t.string   "city",                limit: 255
    t.text     "notification_params"
    t.string   "status",              limit: 255
    t.string   "transaction_id",      limit: 255
    t.datetime "purchased_at"
    t.string   "payment_status",      limit: 255
  end

  create_table "payment_notifications", force: :cascade do |t|
    t.text     "params"
    t.integer  "order_id"
    t.string   "status",         limit: 255
    t.string   "transaction_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "gig_id"
    t.integer  "user_id"
    t.string   "subject",              limit: 255
    t.text     "body"
    t.integer  "communication_rating"
    t.integer  "service_rating"
    t.integer  "recommend_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",        limit: 255
  end

  add_index "subcategories", ["slug"], name: "index_subcategories_on_slug", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",           null: false
    t.string   "encrypted_password",     limit: 255, default: "",           null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "username",               limit: 255
    t.text     "description"
    t.string   "level",                  limit: 255, default: "New Seller", null: false
    t.string   "role",                   limit: 255, default: "Member"
    t.string   "name",                   limit: 255
    t.string   "address_one",            limit: 255
    t.string   "address_two",            limit: 255
    t.string   "zipcode",                limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "country",                limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
