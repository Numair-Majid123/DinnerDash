# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'with validation tests' do
    # bad
    it 'ensures name presence' do
      item = described_class.new(price: 123, description: 'qwerty', status: 1).save
      expect(item).to eq(false)
    end

    # bad
    it 'ensures price presence' do
      item = described_class.new(name: 'qwerty', description: 'qwerty', status: 1).save
      expect(item).to eq(false)
    end

    # bad
    it 'ensures description presence' do
      item = described_class.new(name: 'qwerty', price: 123, status: 1).save
      expect(item).to eq(false)
    end

    # association
    it 'have many orders' do
      t = described_class.reflect_on_association(:orders)
      expect(t.macro).to eq(:has_many)
    end

    # association
    it 'have many categories' do
      t = described_class.reflect_on_association(:categories)
      expect(t.macro).to eq(:has_many)
    end

    # good
    it 'saves successfully' do
      item = described_class.new(name: 'qwerty', price: 123, status: 1, description: 'qwerty')
      expect(item).to be_valid
    end

    it { is_expected.to validate_length_of(:description).is_at_least(5).is_at_most(500) }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(32) }
    it { is_expected.to validate_numericality_of(:price) }
    it { is_expected.to validate_numericality_of(:status) }
  end
end
