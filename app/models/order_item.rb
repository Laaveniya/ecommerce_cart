class OrderItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  before_save :set_total_price
  before_save :set_unit_price

  def unit_price
    if persisited?
      unit_price
    else
      product.rate
    end
  end

  def discount
    Service::Checkout.new(self).process
  end

  def total_price
    (unit_price * quantity) - discount
  end

  private

  def set_total_price
    self[:total_price] = total_price
  end

  def set_unit_price
    self[:unit_price] = unit_price
  end
end
