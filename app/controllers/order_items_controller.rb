class OrderItemsController < ApplicationController
  include CurrentShoppingCart
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]
  before_action :set_shopping_cart, only: [:create]

  def index
    @order_items = OrderItem.all
  end

  def show
    @order_items = OrderItem.find(params[:id])
  end

  def new
    @order_item = OrderItem.new
  end

  def edit
  end

  def create
    product = Product.find(params[:product_id])
    @order_item = @shopping_cart.add_order_item(product)

    if @order_item.save
      render json: @order_item, status: :created
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order_item.update(order_item_params)
      render :show, status: :ok, location: @order_item
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @shopping_cart = ShoppingCart.find(:cart_id)
    @order_item.destroy

    render json: { message: 'removed' }, status: :ok
  end

  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_items).permit(:product_id)
  end
end
