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

ActiveRecord::Schema.define(version: 20190508143811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "certification_names", force: :cascade do |t|
    t.string "provider"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "certifications", force: :cascade do |t|
    t.bigint "freelancer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "certification_name_id"
    t.string "vendor_identifier"
    t.index ["certification_name_id"], name: "index_certifications_on_certification_name_id"
    t.index ["freelancer_id"], name: "index_certifications_on_freelancer_id"
  end

  create_table "chatroom_users", force: :cascade do |t|
    t.bigint "chatroom_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_chatroom_users_on_chatroom_id"
    t.index ["user_id", "chatroom_id"], name: "index_chatroom_users_on_user_id_and_chatroom_id", unique: true
    t.index ["user_id"], name: "index_chatroom_users_on_user_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cloud_services", force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token"
    t.string "name"
    t.string "line1"
    t.string "line2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_4"
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "educations", force: :cascade do |t|
    t.string "school_name"
    t.integer "graduation_year"
    t.bigint "freelancer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["freelancer_id"], name: "index_educations_on_freelancer_id"
  end

  create_table "freelancers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "headline"
    t.string "about_me"
    t.integer "rate", default: 30, null: false
    t.string "profile_photo"
    t.string "location"
    t.string "user_name"
    t.string "merchant_id"
    t.string "source_control_url"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "freelancer_id"
    t.text "description"
    t.decimal "hours", precision: 10, scale: 2
    t.string "credit_card_transaction"
    t.string "from"
    t.string "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "acceptance"
    t.integer "total"
    t.boolean "canceled", default: false
    t.index ["freelancer_id"], name: "index_jobs_on_freelancer_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "legal_entities", force: :cascade do |t|
    t.bigint "payout_identity_id"
    t.integer "dob_day"
    t.integer "dob_year"
    t.integer "dob_month"
    t.string "entity_type"
    t.string "address_city"
    t.string "address_line1"
    t.string "address_state"
    t.string "address_country"
    t.string "address_postal_code"
    t.string "last_name"
    t.string "first_name"
    t.string "ssn_last_4"
    t.string "verification_document"
    t.string "business_name"
    t.string "business_tax_id"
    t.string "personal_address_city"
    t.string "personal_address_line1"
    t.string "personal_address_postal_code"
    t.string "personal_id_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payout_identity_id"], name: "index_legal_entities_on_payout_identity_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "chatroom_id"
    t.bigint "user_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "notification_sent", default: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "missing_payout_fields", force: :cascade do |t|
    t.bigint "payout_identity_id"
    t.string "field"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payout_identity_id"], name: "index_missing_payout_fields_on_payout_identity_id"
  end

  create_table "payout_identities", force: :cascade do |t|
    t.bigint "freelancer_id"
    t.string "external_account"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "routing_number"
    t.string "account_number_last_4"
    t.index ["freelancer_id"], name: "index_payout_identities_on_freelancer_id"
  end

  create_table "photos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "revenues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "newsletter_subscription", default: true
    t.boolean "chat_notification_subscription", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_settings_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.bigint "freelancer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cloud_service_id"
    t.index ["freelancer_id"], name: "index_skills_on_freelancer_id"
  end

  create_table "tos_acceptances", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "date", null: false
    t.string "ip", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tos_acceptances_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "credit_card_id"
    t.bigint "job_id"
    t.string "charge_identifier"
    t.integer "amount"
    t.integer "amount_refunded"
    t.bigint "freelancer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["credit_card_id"], name: "index_transactions_on_credit_card_id"
    t.index ["freelancer_id"], name: "index_transactions_on_freelancer_id"
    t.index ["job_id"], name: "index_transactions_on_job_id", unique: true
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "chat_notification_subscription", default: true
    t.boolean "newsletter_subscription", default: true
    t.string "unsub_token"
    t.string "credit_card_token"
    t.string "relay_user_name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_experiences", force: :cascade do |t|
    t.string "title", null: false
    t.string "employer"
    t.string "achievements"
    t.string "from", null: false
    t.string "to"
    t.bigint "freelancer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["freelancer_id"], name: "index_work_experiences_on_freelancer_id"
  end

  add_foreign_key "chatroom_users", "chatrooms"
  add_foreign_key "chatroom_users", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
end
