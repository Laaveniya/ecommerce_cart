class ProductDiscountRule < ApplicationRecord
  belongs_to :product
  scope :active, -> {
    where('start_date >= :start_date, end_date <= :end_date', start_date: Date.current, end_date: Date.current)
  }
end
