# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let!(:product) do
    FactoryBot.create(:product, name: 'A', code: 'A', rate: 20.0)
  end
  it 'has many product discount rules' do
    assc = described_class.reflect_on_association(:product)
    expect(assc.macro).to eq :belongs_to
  end

  it 'has many order items' do
    assc = described_class.reflect_on_association(:shopping_cart)
    expect(assc.macro).to eq :belongs_to
  end

  it 'unit price and total price should be set when order item is created' do
    order_item = described_class.new(product_id: product.id)
    expect(order_item.unit_price).to be_present
    expect(order_item.total_price).to be_present
  end
end
