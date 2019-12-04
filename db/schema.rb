# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_191_202_034_822) do
  create_table 'cart_discount_rules', force: :cascade do |t|
    t.float 'min_value'
    t.string 'max_value'
    t.float 'discount_percent'
    t.float 'flat_discount'
    t.date 'start_date'
    t.date 'end_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'order_items', force: :cascade do |t|
    t.integer 'quantity', default: 1
    t.float 'total_price'
    t.float 'unit_price'
    t.integer 'product_id'
    t.integer 'shopping_cart_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['product_id'], name: 'index_order_items_on_product_id'
    t.index ['shopping_cart_id'], name: 'index_order_items_on_shopping_cart_id'
  end

  create_table 'product_discount_rules', force: :cascade do |t|
    t.string 'product_code'
    t.integer 'multiples'
    t.float 'offer_price'
    t.float 'percent'
    t.date 'start_date'
    t.date 'end_date'
    t.integer 'product_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['product_id'], name: 'index_product_discount_rules_on_product_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.string 'code'
    t.string 'brand'
    t.float 'rate'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'shopping_carts', force: :cascade do |t|
    t.float 'discount'
    t.float 'sub_total'
    t.float 'total_amount'
  end
end
