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

ActiveRecord::Schema[8.1].define(version: 2026_04_19_154430) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "logo"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "company_users", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "role", default: "member", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["company_id", "user_id"], name: "index_company_users_on_company_id_and_user_id", unique: true
    t.index ["company_id"], name: "index_company_users_on_company_id"
    t.index ["user_id"], name: "index_company_users_on_user_id"
  end

  create_table "contract_templates", force: :cascade do |t|
    t.text "body"
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.jsonb "field_config", default: {}
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.text "content"
    t.bigint "contract_template_id", null: false
    t.datetime "created_at", null: false
    t.jsonb "data"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["contract_template_id"], name: "index_contracts_on_contract_template_id"
    t.index ["user_id"], name: "index_contracts_on_user_id"
  end

  create_table "custom_templates", force: :cascade do |t|
    t.text "body"
    t.bigint "company_id", null: false
    t.bigint "contract_template_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.jsonb "field_config"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_custom_templates_on_company_id"
    t.index ["contract_template_id"], name: "index_custom_templates_on_contract_template_id"
  end

  create_table "payment_simulators", force: :cascade do |t|
    t.integer "amount", null: false
    t.datetime "created_at", null: false
    t.string "plan", null: false
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_payment_simulators_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at"
    t.boolean "lifetime", default: false, null: false
    t.string "plan", default: "free", null: false
    t.datetime "starts_at", null: false
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id", unique: true
  end

  create_table "support_tickets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.string "priority", default: "normal", null: false
    t.string "status", default: "open", null: false
    t.string "subject", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_support_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "companies", "users"
  add_foreign_key "company_users", "companies"
  add_foreign_key "company_users", "users"
  add_foreign_key "contracts", "contract_templates"
  add_foreign_key "contracts", "users"
  add_foreign_key "custom_templates", "companies"
  add_foreign_key "custom_templates", "contract_templates"
  add_foreign_key "payment_simulators", "users"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "support_tickets", "users"
end
