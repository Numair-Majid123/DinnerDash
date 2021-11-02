# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user1) { FactoryBot.create(:user) }

  context 'with invalid tests' do
    it 'ensures name presence' do
      category = described_class.new(name: '')
      expect(category.valid?).to eq(false)
    end
  end

  context 'with association' do
    it 'have many items' do
      t = described_class.reflect_on_association(:items)
      expect(t.macro).to eq(:has_many)
    end

    it 'have many category_items' do
      t = described_class.reflect_on_association(:category_items)
      expect(t.macro).to eq(:has_many)
    end
  end

  context 'with valid tests' do
    it 'saves successfully' do
      category = described_class.new(name: user1.name)
      expect(category.valid?).to eq(true)
    end

    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(32) }
  end
end
