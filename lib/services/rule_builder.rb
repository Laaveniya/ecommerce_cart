class RuleBuilder
  attr_accessor :products
  def initialize(products)
    @products = products
  end

  def rules
    products.each_with_object({}) do |product, hash|
      discount_rule = discount_rules.find_by_product_code(product.code)
      hash[product.code] = PriceVariant(product.rate) && next if discount_rule.nil?
      hash[product.code] =
        PriceVariant(
          product.rate,
          Discount.new(discount_rule.flat_rate, discount_rule.multiples)
        )
    end
  end

  def discount_rules
    @discount_rules ||= DiscountRule.active.where(product_code: product_codes)
  end

  def product_codes
    products.pluck(:product_code)
  end
end
