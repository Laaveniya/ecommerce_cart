class ShoppingCartsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  before_action :set_shopping_cart, only: [:show, :edit, :destroy, :checkout]

  def show
    @shopping_cart
  end

  def new
    @shopping_cart = ShoppingCart.new
  end

  def edit
  end

  def create
    @shopping_cart = ShoppingCart.new(shopping_cart_params)

    if @shopping_cart.save
       render json: @shopping_cart, status: :created
    else
      render json: @shopping_cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @shopping_cart.destroy if @shopping_cart.id = session[:shopping_cart_id]
    session[:shopping_cart_id] = nil
    render json: { message: 'removed' }, status: :ok
  end

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

  def shopping_cart_params
    params.fetch(:order_items, {})
  end

  def invalid_cart
    logger.error "Cart does not exist #{params[:id]}"
    redirect_to products_path, notice: 'The cart does not exist'
  end
end
