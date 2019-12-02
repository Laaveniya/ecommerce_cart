class Discount
  def initialize(value, quantity)
    @value = value
    @quantity = quantity
  end

  def calculate_for(quantity)
    (quantity / @quantity).floor * @value
  end
end
