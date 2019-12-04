# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductDiscountRule, type: :model do
  let!(:product) do
    FactoryBot.create(:product, name: 'A', code: 'A', rate: 20.0)
  end

  context 'association' do
    it 'belongs to product' do
      assc = described_class.reflect_on_association(:product)
      expect(assc.macro).to eq :belongs_to
    end
  end

  context 'record validations' do
    it 'should be valid with valid attributes' do
      discount_rule = described_class.new(
        product_id: product.id,
        product_code: 'A',
        start_date: Date.current,
        end_date: Date.current + 1.year,
        multiples: 2,
        offer_price: 30
      )
      expect(discount_rule.valid?).to be_truthy
    end

    it 'should not be valid with start_date as nil' do
      discount_rule = described_class.new(
        product_id: product.id,
        product_code: 'A',
        start_date: nil,
        end_date: Date.current + 1.year,
        multiples: 2,
        offer_price: 30
      )
      expect(discount_rule.valid?).to be_falsey
      expect(discount_rule.errors).to be_present
    end

    it 'should not be valid with end_date as nil' do
      discount_rule = described_class.new(
        product_id: product.id,
        product_code: 'A',
        start_date: Date.current,
        end_date: nil,
        multiples: 2,
        offer_price: 30
      )
      expect(discount_rule.valid?).to be_falsey
      expect(discount_rule.errors).to be_present
    end

    it 'should not be valid with multiples as nil' do
      discount_rule = described_class.new(
        product_id: product.id,
        product_code: 'A',
        start_date: Date.current,
        end_date: Date.current + 1.year,
        multiples: nil,
        offer_price: 30
      )
      expect(discount_rule.valid?).to be_falsey
      expect(discount_rule.errors).to be_present
    end
  end

  context 'scopes' do
    it 'returns active discount rules' do
      described_class.create!(
        product_id: product.id,
        product_code: 'A',
        start_date: Date.current - 2.days,
        end_date: Date.current + 1.year,
        multiples: 2,
        offer_price: 30
      )
      expect(ProductDiscountRule.active.count).to eq(1)
    end

    it 'returns no rows when there are no active discount rules' do
      described_class.create!(
        product_id: product.id,
        product_code: 'A',
        start_date: Date.current - 1.year,
        end_date: Date.current - 2.days,
        multiples: 2,
        offer_price: 30
      )
      expect(ProductDiscountRule.active.count).to eq(0)
    end
  end
end
