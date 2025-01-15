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

ActiveRecord::Schema[8.0].define(version: 2024_12_03_221401) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_banks_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "last_four_digits"
    t.integer "payment_due_date"
    t.integer "closing_date"
    t.float "credit_limit"
    t.string "card_type", default: "credit"
    t.bigint "bank_id", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["bank_id"], name: "index_cards_on_bank_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.float "total_amount"
    t.float "charge_amount"
    t.float "rest_amount"
    t.datetime "expence_date", null: false
    t.integer "number_payment"
    t.string "description"
    t.string "expence_type", default: "GENERAL"
    t.bigint "user_id", null: false
    t.bigint "sub_category_id", null: false
    t.bigint "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_expenses_on_card_id"
    t.index ["sub_category_id"], name: "index_expenses_on_sub_category_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true, null: false
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id"
    t.index ["user_id"], name: "index_sub_categories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_role", default: "CLIENT"
  end

  add_foreign_key "banks", "users"
  add_foreign_key "cards", "banks"
  add_foreign_key "cards", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "expenses", "cards"
  add_foreign_key "expenses", "sub_categories"
  add_foreign_key "expenses", "users"
  add_foreign_key "sub_categories", "categories"
  add_foreign_key "sub_categories", "users"
end
