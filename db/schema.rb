# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_11_083513) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "full_phone_number"
    t.integer "country_code"
    t.bigint "phone_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "password_digest"
  end

  
  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogue_variant_colors", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogue_variant_sizes", force: :cascade do |t|
    t.string "name"
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogue_variants", force: :cascade do |t|
    t.integer "catalogue_id"
    t.integer "catalogue_variant_color_id"
    t.integer "catalogue_variant_size_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogues", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "category_id"
    t.integer "sub_category_id"
    t.integer "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_otps", force: :cascade do |t|
    t.string "email"
    t.datetime "valid_until"
    t.boolean "activated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "otp"
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_email_otps_on_account_id"
  end

  create_table "sms_otps", force: :cascade do |t|
    t.string "full_phone_number"
    t.datetime "valid_until"
    t.boolean "activated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "otp"
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_sms_otps_on_account_id"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "wallet_id", null: false
    t.bigint "catalogue_variant_id", null: false
    t.decimal "amount", precision: 10, scale: 2
    t.string "transaction_type"
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catalogue_variant_id"], name: "index_transactions_on_catalogue_variant_id"
    t.index ["wallet_id"], name: "index_transactions_on_wallet_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.decimal "balance", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_wallets_on_account_id"
  end

  add_foreign_key "email_otps", "accounts"
  add_foreign_key "sms_otps", "accounts"
  add_foreign_key "sub_categories", "categories"
  add_foreign_key "transactions", "catalogue_variants"
  add_foreign_key "transactions", "wallets"
  add_foreign_key "wallets", "accounts"
end
