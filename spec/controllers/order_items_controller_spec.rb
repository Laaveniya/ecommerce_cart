# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let!(:product1) do
    FactoryBot.create(:product, name: 'A', code: 'A', rate: 20.0)
  end
  let!(:product2) do
    FactoryBot.create(:product, name: 'B', code: 'B', rate: 30.0)
  end

  context 'Add items multiple items to cart' do
    it 'add one item to cart' do
      post :create, params: { format: :json, product_id: product1.id }
      expect(ShoppingCart.count).to eq(1)
      expect(response.status).to eq(201)
      expect(OrderItem.count).to eq(1)
    end
  end
end
