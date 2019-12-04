# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Checkout do
  let!(:a) { FactoryBot.create(:product, name: 'A', code: 'A', rate: 30.0) }
  let!(:b) { FactoryBot.create(:product, name: 'B', code: 'B', rate: 20.0) }
  let!(:c) { FactoryBot.create(:product, name: 'C', code: 'C', rate: 50.0) }
  let!(:d) { FactoryBot.create(:product, name: 'D', code: 'D', rate: 15.0) }
  let!(:a_rule) do
    FactoryBot.create(
      :product_discount_rule, multiples: 3, offer_price: 75, product_id: a.id
    )
  end
  let!(:b_rule) do
    FactoryBot.create(
      :product_discount_rule, multiples: 2, offer_price: 35, product_id: b.id
    )
  end
  let!(:cart_rule) do
    FactoryBot.create(:cart_discount_rule, min_value: 150, flat_discount: 20.0)
  end

  context 'Add items multiple items to cart' do
    it 'returns the detailed_bill for three items in the cart' do
      expected_result = {
        order_items_summary: [
          {
            product_code: 'A',
            quantity: 1,
            unit_price: 30.0,
            discount: 0.0,
            total_price: 30.0
          },
          {
            product_code: 'B',
            quantity: 1,
            unit_price: 20.0,
            discount: 0.0,
            total_price: 20.0
          },
          {
            product_code: 'C',
            quantity: 1,
            unit_price: 50.0,
            discount: 0,
            total_price: 50.0
          }
        ],
        cart_discount: 0.0,
        total_bill_amount: 100.0,
        total_discount: 0.0
      }
      shopping_cart = ShoppingCart.new

      shopping_cart.add_order_item(a).save!
      shopping_cart.add_order_item(b).save!
      shopping_cart.add_order_item(c).save!

      rules = Services::RuleBuilder.new(shopping_cart.order_items).build
      service = described_class.new(rules, shopping_cart)

      expect(service.detailed_bill).to eq(expected_result)
    end

    it 'returns the detailed_bill for five items in the cart' do
      expected_result = {
        order_items_summary: [
          {
            product_code: 'B',
            quantity: 2,
            unit_price: 20.0,
            discount: 5.0,
            total_price: 40.0
          },
          {
            product_code: 'A',
            quantity: 3,
            unit_price: 30.0,
            discount: 15.0,
            total_price: 90.0
          }
        ],
        cart_discount: 0.0,
        total_bill_amount: 110.0,
        total_discount: 20.0
      }
      shopping_cart = ShoppingCart.new

      shopping_cart.add_order_item(b).save!
      shopping_cart.add_order_item(a).save!
      shopping_cart.add_order_item(b).save!
      shopping_cart.add_order_item(a).save!
      shopping_cart.add_order_item(a).save!

      rules = Services::RuleBuilder.new(shopping_cart.order_items).build
      service = described_class.new(rules, shopping_cart)

      expect(service.detailed_bill).to eq(expected_result)
    end

    it 'returns the detailed_bill for seven items in the cart' do
      expected_result = {
        order_items_summary: [
          {
            product_code: 'C',
            quantity: 1,
            unit_price: 50.0,
            discount: 0.0,
            total_price: 50.0
          },
          {
            product_code: 'B',
            quantity: 2,
            unit_price: 20.0,
            discount: 5.0,
            total_price: 40.0
          },
          {
            product_code: 'A',
            quantity: 3,
            unit_price: 30.0,
            discount: 15.0,
            total_price: 90.0
          },
          {
            product_code: 'D',
            quantity: 1,
            unit_price: 15.0,
            discount: 0.0,
            total_price: 15.0
          }
        ],
        cart_discount: 20.0,
        total_bill_amount: 155.0,
        total_discount: 40.0
      }
      shopping_cart = ShoppingCart.new

      shopping_cart.add_order_item(c).save!
      shopping_cart.add_order_item(b).save!
      shopping_cart.add_order_item(a).save!
      shopping_cart.add_order_item(a).save!
      shopping_cart.add_order_item(d).save!
      shopping_cart.add_order_item(a).save!
      shopping_cart.add_order_item(b).save!

      rules = Services::RuleBuilder.new(shopping_cart.order_items).build
      service = described_class.new(rules, shopping_cart)

      expect(service.detailed_bill).to eq(expected_result)
    end

    it 'returns the detailed_bill for five items in the cart' do
      expected_result = {
        order_items_summary: [
          {
            product_code: 'C',
            quantity: 1,
            unit_price: 50.0,
            discount: 0.0,
            total_price: 50.0
          },
          {
            product_code: 'A',
            quantity: 3,
            unit_price: 30.0,
            discount: 15.0,
            total_price: 90.0
          },
          {
            product_code: 'D',
            quantity: 1,
            unit_price: 15.0,
            discount: 0.0,
            total_price: 15.0
          }
        ],
        cart_discount: 0.0,
        total_bill_amount: 140.0,
        total_discount: 15.0
      }
      shopping_cart = ShoppingCart.new

      shopping_cart.add_order_item(c).save!
      shopping_cart.add_order_item(a).save!
      shopping_cart.add_order_item(d).save!
      shopping_cart.add_order_item(a).save!
      shopping_cart.add_order_item(a).save!

      rules = Services::RuleBuilder.new(shopping_cart.order_items).build
      service = described_class.new(rules, shopping_cart)

      expect(service.detailed_bill).to eq(expected_result)
    end
  end
end
