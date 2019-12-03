class OrderItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :product
  before_save :set_total_price
  before_save :set_unit_price

  def unit_price
    product.rate
  end

  def total_price
    (product.rate * quantity)
  end

  def total_price_after_discount
    total_price - discount
  end

  def discount
    service = ::Services::Discount.new(product, product_discount_rule.try(:multiples))
    service.calculate_for(quantity)
  end

  private

  def product_discount_rule
    @product_discount_rule ||= product.product_discount_rules.last
  end

  def set_total_price
    self[:total_price] = total_price
  end

  def set_unit_price
    self[:unit_price] = unit_price
  end
end
