class Product < ApplicationRecord
  has_many :product_discount_rules, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :rate
  validates_presence_of :code
end
