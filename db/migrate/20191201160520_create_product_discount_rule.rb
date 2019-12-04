# frozen_string_literal: true

class CreateProductDiscountRule < ActiveRecord::Migration[5.2]
  def change
    create_table :product_discount_rules do |t|
      t.string :product_code
      t.integer :multiples
      t.float :offer_price
      t.float :percent
      t.date :start_date
      t.date :end_date
      t.belongs_to :product
      t.timestamps
    end
  end
end
