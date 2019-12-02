class Checkout
  attr_reader :rules
  attr_accessor :order_items

  def initialize(rules)
    @rules = rules
    @order_items = Hash.new
  end

  def scan(order_item)
    order_items[order_item] ||= 0
    order_items[order_item] += 1
  end

  def total
    order_items.inject(0) do |mem, (order_item, quantity)|
      mem + price_for(order_item, quantity)
    end
  end

  def total_discount
    cart_discount = CartDiscount.active.where("min_value <= '?'", total).last
    total - cart_discount.flat_rate
  end

  private
  def price_for(order_item, quantity)
    if rule_for(order_item)
      rule_for(order_item).price_for(quantity)
    else
      raise "Invalid order_item '#{order_item}'"
    end
  end

  def rule_for(order_item)
    rules[order_item]
  end
end
