class PriceVariant
  def initialize(rate, *discounts)
    @rate = rate
    @discounts = discounts
  end

  def price_for(quantity)
    quantity * @rate - discount_for(quantity)
  end

  def discount_for(quantity)
    @discounts.collect { |discount| discount.calculate_for(quantity) }.sum
  end
end
