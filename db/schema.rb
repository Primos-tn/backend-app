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

ActiveRecord::Schema.define(version: 20161204023903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_registration_invitations", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "email"
    t.integer  "admin_sent_by"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username"
    t.integer  "account_type",           default: 0
    t.boolean  "is_super_admin",         default: false
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree
  add_index "accounts", ["username"], name: "index_accounts_on_username", unique: true, using: :btree

  create_table "api_keys", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "value"
    t.datetime "valide_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "creator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.integer  "brand_id"
  end

  create_table "brand_comments", force: :cascade do |t|
    t.integer  "brand_id"
    t.integer  "author_id"
    t.string   "comment"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "likes_count", default: 0
  end

  create_table "brand_team_members", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "brand_id"
    t.boolean  "is_admin"
    t.integer  "added_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "account_id"
    t.integer  "brand_users_followers_count", default: 0
    t.integer  "comments_count",              default: 0
    t.json     "picture"
    t.string   "cover"
  end

  add_index "brands", ["account_id"], name: "index_brands_on_account_id", using: :btree

  create_table "business_profiles", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "plan_type",    default: 0
    t.datetime "expires"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "is_confirmed", default: false
    t.boolean  "is_blocked",   default: false
  end

  create_table "business_systems", force: :cascade do |t|
    t.float    "offer_basic_price",                    default: 10.0
    t.json     "supported_countries",                  default: ["TN", "FR"]
    t.integer  "last_modified_by"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.json     "crash_mails_alert",                    default: []
    t.json     "account_expires_requests_mails_alert", default: []
    t.json     "business_requests_mail_alert",         default: []
    t.json     "contacts_mail_alert",                  default: []
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "parent_id"
    t.string   "name_ar"
    t.string   "name_fr"
  end

  create_table "categories_products", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.string   "body"
    t.string   "type"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "seen",       default: 0
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "code"
    t.string   "real_name"
  end

  create_table "product_comments", force: :cascade do |t|
    t.string   "comment"
    t.integer  "author_id"
    t.integer  "likes_count"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "product_coupons", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "value"
    t.datetime "expires"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_stores", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "product_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "available_count", default: 0
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.datetime "last_launch"
    t.integer  "user_product_views_count",  default: 0
    t.integer  "user_product_wishes_count", default: 0
    t.integer  "available_in_count",        default: 0
    t.integer  "comments_count",            default: 0
    t.json     "pictures"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "phone"
    t.string   "first_name"
    t.string   "avatar"
    t.string   "last_name"
    t.integer  "postcode"
    t.integer  "account_id"
    t.integer  "country_id"
    t.date     "birthdate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "avatar_tiny"
    t.integer  "age"
    t.json     "pictures"
    t.string   "address"
  end

  add_index "profiles", ["account_id"], name: "index_profiles_on_account_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.point    "position"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "city"
    t.string   "country_code"
    t.string   "address"
    t.string   "zip_code"
  end

  create_table "system_configurations", force: :cascade do |t|
    t.json     "supported_languages", default: ["ar", "en", "fr"]
    t.json     "crash_mails_alert",   default: []
    t.integer  "last_modified_by"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "with_invitation",     default: true
  end

  create_table "user_brand_following_relationships", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_brand_following_relationships", ["account_id"], name: "index_user_brand_following_relationships_on_account_id", using: :btree
  add_index "user_brand_following_relationships", ["brand_id"], name: "index_user_brand_following_relationships_on_brand_id", using: :btree

  create_table "user_product_shares", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "product_id"
    t.json     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_product_views", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_product_wishes", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "webhooks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "brands", "accounts"
  add_foreign_key "user_brand_following_relationships", "accounts"
  add_foreign_key "user_brand_following_relationships", "brands"
end
