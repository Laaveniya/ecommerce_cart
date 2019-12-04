# frozen_string_literal: true

class OrderItemsController < ApplicationController
  include CurrentShoppingCart
  before_action :set_shopping_cart, only: %i[create]

  def create
    product = Product.find(params[:product_id])
    @order_item = @shopping_cart.add_order_item(product)

    if @order_item.save
      render json: @order_item, status: :created
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end
  end

  private

  def order_item_params
    params.require(:order_items).permit(:product_id)
  end
end
