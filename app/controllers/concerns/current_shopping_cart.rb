# frozen_string_literal: true

module CurrentShoppingCart
  private

  def set_shopping_cart
    @shopping_cart = ShoppingCart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @shopping_cart = ShoppingCart.create
    session[:shopping_cart_id] = @shopping_cart.id
  end
end
