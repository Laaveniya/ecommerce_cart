# frozen_string_literal: true

class ShoppingCartsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  before_action :set_shopping_cart, only: %i[checkout]

  def checkout
    rules = ::Services::RuleBuilder.new(@shopping_cart.order_items).build
    service = ::Services::Checkout.new(rules, @shopping_cart)
    if service.process
      render json: service.detailed_bill
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  private

  def set_shopping_cart
    @shopping_cart = ShoppingCart.find(params[:id])
  end

  def invalid_cart
    logger.error "Cart does not exist #{params[:id]}"
    redirect_to products_path, notice: 'The cart does not exist'
  end
end
