# frozen_string_literal: true

class ProductDiscountRule < ApplicationRecord
  belongs_to :product
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :multiples

  scope :active, lambda {
    where('start_date <= ? AND end_date >= ?', Date.current, Date.current)
  }
end
