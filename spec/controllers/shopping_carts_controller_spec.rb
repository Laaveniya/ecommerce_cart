# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShoppingCartsController, type: :controller do
  let!(:product1) do
    FactoryBot.create(:product, name: 'A', code: 'A', rate: 20.0)
  end
  let!(:product2) do
    FactoryBot.create(:product, name: 'B', code: 'B', rate: 30.0)
  end
  let!(:product_discount_rule1) do
    FactoryBot.create(
      :product_discount_rule,
      multiples: 3,
      offer_price: 50,
      product_id: product1.id
    )
  end
  context 'checkout' do
    it 'gives detailed bill on checkout' do
      expected_response =
        {
          order_items_summary: [
            {
              product_code: 'A',
              quantity: 3,
              unit_price: 20.0,
              discount: 10.0,
              total_price: 60.0
            },
            {
              product_code: 'B',
              quantity: 1,
              unit_price: 30.0,
              discount: 0,
              total_price: 30.0
            }
          ],
          cart_discount: 0.0,
          total_bill_amount: 80.0,
          total_discount: 10.0
        }
      shopping_cart = ShoppingCart.new
      shopping_cart.add_order_item(product1).save!
      shopping_cart.add_order_item(product1).save!
      shopping_cart.add_order_item(product1).save!
      shopping_cart.add_order_item(product2).save!
      put :checkout, params: { id: shopping_cart.id, format: :json }

      expect(response.status).to eq(200)
      expect(
        JSON.parse(response.body).deep_symbolize_keys
      ).to eq(expected_response)
    end
  end
end
