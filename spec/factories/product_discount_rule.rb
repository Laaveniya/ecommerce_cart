FactoryBot.define do
  factory :product_discount_rule, class: ProductDiscountRule do
    start_date { Date.current }
    end_date { Date.current + 1.year }
  end
end
