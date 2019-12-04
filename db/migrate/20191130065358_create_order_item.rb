# frozen_string_literal: true

class CreateOrderItem < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :quantity, default: 1
      t.float :total_price
      t.float :unit_price
      t.references :product, foreign_key: true
      t.belongs_to :shopping_cart, foreign_key: true

      t.timestamps
    end
  end
end
