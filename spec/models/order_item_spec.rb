# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order1) { FactoryBot.create :order }
  let(:item1) { FactoryBot.create :item }

  context 'with invalid tests' do
    # bad
    it 'ensures item_id presence' do
      item = described_class.new(quantity: 8, order_id: order1.id)
      expect(item.valid?).to eq(false)
    end

    # bad
    it 'ensures order_id presence' do
      item = described_class.new(quantity: 8, item_id: item1.id)
      expect(item.valid?).to eq(false)
    end
  end

  context 'with valid tests' do
    # association with item
    it 'has many items' do
      association = described_class.reflect_on_association(:item)
      expect(association.macro).to eq(:belongs_to)
    end

    # association with category
    it 'has many orders' do
      association = described_class.reflect_on_association(:order)
      expect(association.macro).to eq(:belongs_to)
    end

    # good
    it 'saves successfully' do
      item = described_class.new(item_id: item1.id, order_id: order1.id, quantity: 1)
      expect(item).to be_valid
    end

    it { is_expected.to validate_numericality_of(:quantity) }
  end
end
