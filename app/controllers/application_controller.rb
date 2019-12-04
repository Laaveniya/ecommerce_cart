# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CurrentShoppingCart
  before_action :set_shopping_cart
end
