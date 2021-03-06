# frozen_string_literal: true

class Product < ApplicationRecord
  before_destroy :not_reference_by_any_order_item
  has_many :product_discount_rules, dependent: :destroy
  has_many :order_items
  validates_presence_of :name
  validates_presence_of :rate
  validates_presence_of :code
  validates_presence_of :brand

  private

  def not_reference_by_any_order_item
    return if order_items.empty?

    errors.add(:base, 'order items present')
    throw :abort
  end
end
