# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item1) { FactoryBot.create :item }

  context 'with invalid tests' do
    # bad
    it 'ensures name presence' do
      item = described_class.new(price: item1.price, description: item1.description, status: item1.status)
      expect(item.valid?).to eq(false)
    end

    # bad
    it 'ensures price presence' do
      item = described_class.new(name: item1.name, description: item1.description, status: item1.status)
      expect(item.valid?).to eq(false)
    end

    # bad
    it 'ensures description presence' do
      item = described_class.new(name: item1.name, price: item1.price, status: item1.status)
      expect(item.valid?).to eq(false)
    end
  end

  context 'with valid tests' do
    # association
    it 'has many orders' do
      t = described_class.reflect_on_association(:orders)
      expect(t.macro).to eq(:has_many)
    end

    # association
    it 'has many categories' do
      t = described_class.reflect_on_association(:categories)
      expect(t.macro).to eq(:has_many)
    end

    # good
    it 'saves successfully' do
      item = described_class.new(name: item1.name, price: item1.price,
                                 status: item1.status, description: item1.description)
      expect(item).to be_valid
    end

    it { is_expected.to validate_length_of(:description).is_at_least(5).is_at_most(500) }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(32) }
    it { is_expected.to validate_numericality_of(:price) }
    it { is_expected.to validate_numericality_of(:status) }
  end
end
