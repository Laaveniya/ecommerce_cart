class CartDiscountRule < ApplicationRecord
  scope :active, -> { where('start_date >= ?, end_date <= ?', Date.current, Date.current) }
end
