require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let!(:product1) {FactoryBot.create(:product, name: 'A', code: 'A', rate: 20.0)}
  let!(:product2) {FactoryBot.create(:product, name: 'B', code: 'B', rate: 30.0)}
  it '#index' do
    get :index, params: { format: :json }
    expect(response.status).to eq(204)
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
