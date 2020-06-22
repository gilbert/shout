# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_22_002300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "debug_logs", force: :cascade do |t|
    t.integer "action", null: false
    t.uuid "request_id", default: -> { "gen_random_uuid()" }, null: false
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "field_test_memberships", force: :cascade do |t|
    t.string "participant_type"
    t.string "participant_id"
    t.string "experiment"
    t.string "variant"
    t.datetime "created_at"
    t.boolean "converted", default: false
    t.index ["experiment", "created_at"], name: "index_field_test_memberships_on_experiment_and_created_at"
    t.index ["participant_type", "participant_id", "experiment"], name: "index_field_test_memberships_on_participant", unique: true
  end

  create_table "journal_entries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "journal_id", null: false
    t.bigint "journal_prompt_id"
    t.string "body", null: false
    t.datetime "responded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["journal_id"], name: "index_journal_entries_on_journal_id"
    t.index ["journal_prompt_id"], name: "index_journal_entries_on_journal_prompt_id"
    t.index ["user_id"], name: "index_journal_entries_on_user_id"
  end

  create_table "journal_prompts", force: :cascade do |t|
    t.bigint "journal_id", null: false
    t.bigint "prompt_schedule_id", null: false
    t.integer "ref_id"
    t.string "body"
    t.datetime "send_at"
    t.datetime "sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["journal_id"], name: "index_journal_prompts_on_journal_id"
    t.index ["prompt_schedule_id"], name: "index_journal_prompts_on_prompt_schedule_id"
  end

  create_table "journals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "public_uid", null: false
    t.string "name", null: false
    t.string "encrypted_password", limit: 128
    t.jsonb "data", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_journals_on_user_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prompt_schedules", force: :cascade do |t|
    t.bigint "journal_id", null: false
    t.string "type"
    t.string "status", default: "active", null: false
    t.jsonb "data", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["journal_id"], name: "index_prompt_schedules_on_journal_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "plan", null: false
    t.string "status", null: false
    t.jsonb "data", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "url_words", force: :cascade do |t|
    t.string "word"
    t.datetime "expires_at"
    t.bigint "link_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["link_id"], name: "index_url_words_on_link_id"
    t.index ["word"], name: "index_url_words_on_word"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", null: false
    t.string "name"
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.string "timezone"
    t.string "phone"
    t.string "status", default: "new", null: false
    t.boolean "phone_consent", default: false, null: false
    t.datetime "free_trial_ends", null: false
    t.jsonb "data", default: {}, null: false
    t.boolean "superadmin", default: false, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["phone"], name: "index_users_on_phone"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "journal_entries", "journal_prompts"
  add_foreign_key "journal_entries", "journals"
  add_foreign_key "journal_entries", "users"
  add_foreign_key "journal_prompts", "journals"
  add_foreign_key "journal_prompts", "prompt_schedules"
  add_foreign_key "journals", "users"
  add_foreign_key "prompt_schedules", "journals"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "url_words", "links"
end
