class ShoppingCart < ApplicationRecord
  has_many :order_items, dependent: :destroy

  def add_order_item(product)
    current_item = order_items.find_by(product_id: product.id)
    if current_item
      current_item.increment(:quantity)
    else
      current_item = order_items.build(product_id: product.id)
    end
    current_item
  end

  def sub_total
    order_items.collect(&:total_price).sum
  end

  def discount_price
    Service::Discount.new(product, quantity).apply
  end

  def total_price
    sub_total - discount_price
  end
end
