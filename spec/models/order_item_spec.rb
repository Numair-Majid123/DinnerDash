# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order1) { FactoryBot.create :order }
  let(:item1) { FactoryBot.create :item }

  context 'with invalid tests' do
    it 'Fails: ensures item_id presence' do
      item = described_class.new(quantity: 8, order_id: order1.id)
      expect(item.valid?).to eq(false)
    end

    it 'Fails: ensures order_id presence' do
      item = described_class.new(quantity: 8, item_id: item1.id)
      expect(item.valid?).to eq(false)
    end

    it 'Fails: ensures quantity greater than 0' do
      item = described_class.new(quantity: 0, item_id: item1.id, order_id: order1.id)
      expect(item.valid?).to eq(false)
    end

    it 'Fails: ensures quantity less than 100' do
      item = described_class.new(quantity: 101, item_id: item1.id, order_id: order1.id)
      expect(item.valid?).to eq(false)
    end
  end

  context 'with associations' do
    it 'belongs to items' do
      association = described_class.reflect_on_association(:item)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to orders' do
      association = described_class.reflect_on_association(:order)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  context 'with valid tests' do
    it 'saves successfully' do
      item = described_class.new(item_id: item1.id, order_id: order1.id, quantity: 1)
      expect(item).to be_valid
    end

    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(1).is_less_than(100) }
  end
end
