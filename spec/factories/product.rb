# frozen_string_literal: true

FactoryBot.define do
  factory :product, class: Product do
    brand { 'xyz' }
  end
end
