# frozen_string_literal: true

FactoryBot.define do
  factory :cart_discount_rule, class: CartDiscountRule do
    start_date { Date.current }
    end_date { Date.current + 1.year }
  end
end
