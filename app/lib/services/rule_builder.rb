module Services
  class RuleBuilder
    attr_accessor :order_items
    def initialize(order_items)
      @order_items = order_items
    end

    def build
      products.each_with_object({}) do |product, hash|
        product_discount = product.product_discount_rules.last
        hash[product.code] = PriceVariant.new(product.rate) && next if product_discount.nil?
        hash[product.code] =
          PriceVariant.new(
            product.rate,
            Discount.new(product, product_discount.multiples)
          )
      end
    end

    def products
      @products ||= Product.includes(:product_discount_rules).find(product_ids)
    end

    def product_ids
      order_items.pluck(:product_id).uniq
    end
  end
end
