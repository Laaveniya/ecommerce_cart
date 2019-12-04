# frozen_string_literal: true

module Services
  class Checkout
    attr_reader :rules
    attr_accessor :shopping_cart

    def initialize(rules, shopping_cart)
      @rules = rules
      @shopping_cart = shopping_cart
    end

    def process
      shopping_cart.update_attributes!(
        sub_total: sub_total,
        discount: total_discount,
        total_amount: total
      )
    end

    def detailed_bill
      {
        order_items_summary: calculate_item_bill,
        cart_discount: cart_discount,
        total_bill_amount: total - cart_discount,
        total_discount: total_discount
      }
    end

    private

    def sub_total
      order_items.collect(&:total_price).sum
    end

    def calculate_item_bill
      order_items.map do |order_item|
        {
          product_code: order_item.product.code,
          quantity: order_item.quantity,
          unit_price: order_item.unit_price,
          discount: order_item.discount,
          total_price: order_item.total_price
        }
      end
    end

    def total_discount
      order_items.collect(&:discount).sum + cart_discount
    end

    def total
      total_value = order_items.inject(0) do |mem, order_item|
        mem + price_for(order_item)
      end
      total_value
    end

    def cart_discount
      @cart_discount ||=
        ::CartDiscountRule
        .active
        .where('min_value <= ?', total)
        .last
        .try(:flat_discount)
        .to_f
    end

    def order_items
      @order_items ||= shopping_cart.order_items
    end

    def price_for(order_item)
      if rule_for(order_item)
        rule_for(order_item).price_for(order_item.quantity)
      else
        order_item.quantity * order_item.product.rate
      end
    end

    def rule_for(order_item)
      rules[order_item.product.code]
    end
  end
end
