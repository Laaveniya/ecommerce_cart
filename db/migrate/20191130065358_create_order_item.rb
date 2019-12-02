class CreateOrderItem < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.float :total_price
    end
  end
end
