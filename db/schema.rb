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

ActiveRecord::Schema.define(version: 20170518212419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_access_tokens", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "type"
    t.string   "uuid"
    t.json     "info"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "token_value"
    t.datetime "expires"
  end

  create_table "account_push_tokens", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "value"
    t.string   "platform"
    t.json     "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uuid"
  end

  create_table "account_registration_invitations", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "email"
    t.integer  "admin_sent_by"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "is_confirmed",      default: false
    t.integer  "invitation_source", default: 0
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
    t.string   "provider"
    t.string   "uid"
    t.string   "provider_access_token"
    t.index ["email"], name: "index_accounts_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_accounts_on_username", unique: true, using: :btree
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "creator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.integer  "brand_id"
  end

  create_table "brand_features", force: :cascade do |t|
    t.integer  "brand_id"
    t.integer  "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brand_galleries", force: :cascade do |t|
    t.integer  "brand_id"
    t.string   "name"
    t.string   "file"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "dominant_colors", default: [],              array: true
  end

  create_table "brand_namespaces", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "brand_id"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brand_reviews", force: :cascade do |t|
    t.integer  "brand_id"
    t.integer  "author_id"
    t.string   "body"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "likes_count", default: 0
    t.integer  "eval",        default: 0
  end

  create_table "brand_team_members", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "brand_id"
    t.boolean  "is_admin"
    t.integer  "added_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brand_user_followers", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_brand_user_followers_on_account_id", using: :btree
    t.index ["brand_id"], name: "index_brand_user_followers_on_brand_id", using: :btree
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "account_id"
    t.integer  "followers_count",           default: 0
    t.integer  "reviews_count",             default: 0
    t.json     "picture"
    t.string   "cover"
    t.integer  "products_count",            default: 0
    t.integer  "stores_count",              default: 0
    t.string   "fb_link"
    t.string   "tw_link"
    t.string   "ln_link"
    t.string   "address"
    t.date     "creation_date"
    t.integer  "category_id"
    t.integer  "messenger_followers_count"
    t.index ["account_id"], name: "index_brands_on_account_id", using: :btree
  end

  create_table "business_api_tokens", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "business_profiles", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "plan_type",               default: 0
    t.datetime "expires"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "is_confirmed",            default: false
    t.boolean  "is_blocked",              default: false
    t.string   "company_name"
    t.string   "city"
    t.integer  "post_code"
    t.string   "country"
    t.string   "business_phone"
    t.string   "business_email"
    t.string   "company_address"
    t.boolean  "pending",                 default: true
    t.boolean  "has_free_account",        default: false
    t.datetime "free_account_started_at"
  end

  create_table "business_systems", force: :cascade do |t|
    t.float    "offer_basic_price",                    default: 10.0
    t.json     "supported_countries",                  default: "[\"TN\", \"FR\"]"
    t.integer  "last_modified_by"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.json     "crash_mails_alert",                    default: "[]"
    t.json     "account_expires_requests_mails_alert", default: "[]"
    t.json     "business_requests_mail_alert",         default: "[]"
    t.json     "contacts_mail_alert",                  default: "[]"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "parent_id"
    t.string   "name_ar"
    t.string   "name_fr"
    t.string   "icon_class_name"
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

  create_table "features", force: :cascade do |t|
    t.string   "name"
    t.string   "name_ar"
    t.string   "name_fr"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gallery_pictures_products", force: :cascade do |t|
    t.integer  "picture_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messenger_account_brand_followers", force: :cascade do |t|
    t.integer  "messenger_account_id"
    t.integer  "brand_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "messenger_accounts", force: :cascade do |t|
    t.string   "user_id"
    t.integer  "last_connexion"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "cover"
    t.string   "locale"
    t.json     "location"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "messenger_discussions", force: :cascade do |t|
    t.string   "user_id"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "to_user"
    t.string   "type"
    t.boolean  "seen",       default: false
    t.json     "info"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "offer_services", force: :cascade do |t|
    t.string   "service_name"
    t.integer  "offer_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
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
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "image_qr_code"
  end

  create_table "product_launches", force: :cascade do |t|
    t.integer  "product_id"
    t.date     "launch_date"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "views_count",            default: 0
    t.integer  "products_collection_id"
    t.time     "start_at"
    t.time     "end_at"
  end

  create_table "product_stores", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "product_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "available_count", default: 0
  end

  create_table "product_taggings", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_taggings_on_product_id", using: :btree
    t.index ["tag_id"], name: "index_product_taggings_on_tag_id", using: :btree
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
    t.json     "properties"
    t.integer  "coupons_counts",            default: 0
    t.float    "old_price"
    t.float    "new_price"
    t.string   "currrency"
    t.integer  "votes_count",               default: 0
  end

  create_table "products_collections", id: :integer, default: -> { "nextval('product_collections_id_seq'::regclass)" }, force: :cascade do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.datetime "last_launch"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "product_size", default: 0
    t.index ["brand_id"], name: "index_product_collections_on_brand_id", using: :btree
  end

  create_table "products_collections_products", force: :cascade do |t|
    t.integer  "products_collection_id"
    t.integer  "product_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
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
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "avatar_tiny"
    t.integer  "age"
    t.json     "pictures"
    t.string   "address"
    t.json     "region_interest"
    t.index ["account_id"], name: "index_profiles_on_account_id", using: :btree
  end

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
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "system_configurations", force: :cascade do |t|
    t.json     "supported_languages", default: "[\"ar\", \"en\", \"fr\"]"
    t.json     "crash_mails_alert",   default: "[]"
    t.integer  "last_modified_by"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.boolean  "with_invitation",     default: true
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_category_interests", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["account_id"], name: "index_user_category_interests_on_account_id", using: :btree
    t.index ["category_id"], name: "index_user_category_interests_on_category_id", using: :btree
  end

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
    t.float    "latitude"
    t.float    "longitude"
    t.inet     "ip_address"
    t.integer  "count"
  end

  create_table "user_product_votes", force: :cascade do |t|
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

  add_foreign_key "brand_user_followers", "accounts"
  add_foreign_key "brand_user_followers", "brands"
  add_foreign_key "brands", "accounts"
  add_foreign_key "product_taggings", "products"
  add_foreign_key "product_taggings", "tags"
  add_foreign_key "user_category_interests", "accounts"
  add_foreign_key "user_category_interests", "categories"
end
