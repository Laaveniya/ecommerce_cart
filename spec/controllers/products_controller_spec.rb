require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:product1) {FactoryBot.create(:product, name: 'A', code: 'A', rate: 20.0)}
  let!(:product2) {FactoryBot.create(:product, name: 'B', code: 'B', rate: 30.0)}

  it '#index' do
    get :index, params: { format: :json }
    expect(response.status).to eq(200)
    expect(response.header['Content-Type']).to include('application/json')
  end
end
