# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:product1) do
    FactoryBot.create(:product, name: 'A', code: 'A', rate: 20.0)
  end
  let!(:product2) do
    FactoryBot.create(:product, name: 'B', code: 'B', rate: 30.0)
  end

  it '#index' do
    get :index, params: { format: :json }
    expect(response.status).to eq(200)
    expect(response.header['Content-Type']).to include('application/json')
  end
end
