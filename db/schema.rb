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

ActiveRecord::Schema.define(version: 20_171_022_184_555) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'authorizations', force: :cascade do |t|
    t.string 'provider'
    t.string 'uid'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[provider uid], name: 'index_authorizations_on_provider_and_uid'
    t.index ['user_id'], name: 'index_authorizations_on_user_id'
  end

  create_table 'books', force: :cascade do |t|
    t.string 'google_book_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'plans', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_plans_on_user_id'
  end

  create_table 'plans_books', force: :cascade do |t|
    t.bigint 'plan_id'
    t.bigint 'book_id'
    t.boolean 'marked', default: false
    t.index ['book_id'], name: 'index_plans_books_on_book_id'
    t.index ['plan_id'], name: 'index_plans_books_on_plan_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.boolean 'admin', default: false
    t.string 'avatar'
    t.boolean 'blocked', default: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'users_books', force: :cascade do |t|
    t.bigint 'book_id'
    t.bigint 'user_id'
    t.index ['book_id'], name: 'index_users_books_on_book_id'
    t.index ['user_id'], name: 'index_users_books_on_user_id'
  end

  add_foreign_key 'authorizations', 'users'
end
