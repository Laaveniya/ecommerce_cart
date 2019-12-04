# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is not valid with not attributes' do
    product = Product.new
    expect(product.valid?).to be_falsey
  end

  it 'is not valid without a name' do
    product = Product.new(name: nil, code: 'A', rate: 20.0, brand: 'xcv')
    expect(product.valid?).to be_falsey
  end

  it 'is not valid without a brand' do
    product = Product.new(name: 'A', code: 'A', rate: 20.0, brand: nil)
    expect(product.valid?).to be_falsey
  end

  it 'is not valid without rate' do
    product = Product.new(name: 'A', code: 'A', rate: nil, brand: 'xyz')
    expect(product.valid?).to be_falsey
  end

  it 'is not valid with valid attributes' do
    product = Product.new(name: 'A', code: 'A', rate: 89, brand: 'xyz')
    expect(product.valid?).to be_truthy
  end

  it 'has many product discount rules' do
    assc = described_class.reflect_on_association(:product_discount_rules)
    expect(assc.macro).to eq :has_many
  end

  it 'has many order items' do
    assc = described_class.reflect_on_association(:order_items)
    expect(assc.macro).to eq :has_many
  end
end
