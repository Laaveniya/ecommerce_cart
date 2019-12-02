class ShoppingCart < ApplicationRecord
  has_many :order_items

  def sub_total
    order_items.collect(&:total_price).sum
  end

  def discount
    Services::Checkout.new(self).compute
  end

  def total_price
    sub_total - discount_price
  end
end
