# frozen_string_literal: true

class ProductDiscountRule < ApplicationRecord
  belongs_to :product
  scope :active, lambda {
    where(
      'start_date >= :start_date, end_date <= :end_date',
      start_date: Date.current,
      end_date: Date.current
    )
  }
end
