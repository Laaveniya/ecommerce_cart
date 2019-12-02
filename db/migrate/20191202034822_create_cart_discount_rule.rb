class CreateCartDiscountRule < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_discount_rules do |t|
      t.float :min_value
      t.string :max_value
      t.float :discount_percent
      t.float :flat_discount
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
