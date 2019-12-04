# frozen_string_literal: true

class CartDiscountRule < ApplicationRecord
  scope :active, lambda {
    where('start_date <= ? AND end_date >= ?', Date.current, Date.current)
  }
end
