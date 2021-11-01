# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context 'with invalid tests' do
    # bad
    it 'ensures item_id presence' do
      item = described_class.new(quantity: 8, order_id: 15)
      expect(item.valid?).to eq(false)
    end

    # bad
    it 'ensures order_id presence' do
      item = described_class.new(quantity: 8, item_id: 89)
      expect(item.valid?).to eq(false)
    end
  end

  context 'with valid tests' do
    # association with item
    it 'have many items' do
      t = described_class.reflect_on_association(:item)
      expect(t.macro).to eq(:belongs_to)
    end

    # association with category
    it 'have many orders' do
      t = described_class.reflect_on_association(:order)
      expect(t.macro).to eq(:belongs_to)
    end

    # good
    it 'saves successfully' do
      item = described_class.new(item_id: 89, order_id: 15, quantity: 1)
      expect(item).to be_valid
    end

    it { is_expected.to validate_numericality_of(:quantity) }
  end
end
