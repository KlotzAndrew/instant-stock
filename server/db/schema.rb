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

ActiveRecord::Schema.define(version: 20160731184659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "cash_holdings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "currency",     null: false
    t.uuid     "portfolio_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["portfolio_id"], name: "index_cash_holdings_on_portfolio_id", using: :btree
  end

  create_table "cash_trades", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "cash_holding_id",                          null: false
    t.decimal  "quantity",        precision: 15, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["cash_holding_id"], name: "index_cash_trades_on_cash_holding_id", using: :btree
  end

  create_table "messages", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "portfolio_id", null: false
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["portfolio_id"], name: "index_messages_on_portfolio_id", using: :btree
  end

  create_table "portfolios", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.boolean  "promo_portfolio", default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "stock_holdings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.boolean  "active",       default: true, null: false
    t.uuid     "portfolio_id",                null: false
    t.uuid     "stock_id",                    null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["portfolio_id"], name: "index_stock_holdings_on_portfolio_id", using: :btree
    t.index ["stock_id"], name: "index_stock_holdings_on_stock_id", using: :btree
  end

  create_table "stock_trades", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "stock_holding_id",                          null: false
    t.integer  "quantity",                                  null: false
    t.decimal  "enter_price",      precision: 15, scale: 2
    t.decimal  "exit_price",       precision: 15, scale: 2
    t.datetime "exit_time"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["stock_holding_id"], name: "index_stock_trades_on_stock_holding_id", using: :btree
  end

  create_table "stocks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "ticker",                                   null: false
    t.string   "stock_exchange",                           null: false
    t.string   "name"
    t.string   "currency",                                 null: false
    t.datetime "last_quote_time"
    t.decimal  "last_quote",      precision: 15, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

end
