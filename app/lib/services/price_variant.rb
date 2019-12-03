module Services
  class PriceVariant
    def initialize(rate, *discounts)
      @rate = rate
      @discounts = discounts
    end

    def price_for(quantity)
      quantity * @rate - discount_for(quantity)
    end

    def discount_for(quantity)
      @discounts.inject(0) do |mem, discount|
        mem + discount.calculate_for(quantity)
      end
    end
  end
end
