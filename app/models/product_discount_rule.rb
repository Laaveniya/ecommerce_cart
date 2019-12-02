class ProductDiscountRule < ApplicationRecord
  belongs_to :product
  scope :active, -> { where("start_date >= '?', end_date <= '?'", Date.current, Date.current) }
end
