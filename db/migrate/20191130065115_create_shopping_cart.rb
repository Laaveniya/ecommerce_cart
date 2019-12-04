# frozen_string_literal: true

class CreateShoppingCart < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_carts do |t|
      t.float :discount
      t.float :sub_total
      t.float :total_amount
    end
  end
end
