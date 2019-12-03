module Services
  class Discount
    attr_reader :product, :multiples
    def initialize(product, multiples)
      @product = product
      @multiples = multiples
    end

    def calculate_for(no_of_units)
      return 0 if multiples.nil?

      total_price(no_of_units) - discounted_price(no_of_units)
    end

    def discounted_price(no_of_units)
      (no_of_units / multiples).floor * offer_price + (no_of_units % multiples) * product.rate
    end

    def total_price(no_of_units)
      no_of_units * product.rate
    end

    def rule
      @rule ||= product.product_discount_rules.last
    end

    def offer_price
      return product.rate unless rule

      rule.offer_price
    end
  end
end
