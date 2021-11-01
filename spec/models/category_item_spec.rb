# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryItem, type: :model do
  let(:category1) { FactoryBot.create :category }
  let(:item1) { FactoryBot.create :item }

  context 'with invalid tests' do
    # bad
    it 'ensures item_id presence' do
      item = described_class.new(category_id: category1.id)
      expect(item.valid?).to eq(false)
    end

    # bad
    it 'ensures category_id presence' do
      item = described_class.new(item_id: item1.id)
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
    it 'have many categories' do
      t = described_class.reflect_on_association(:category)
      expect(t.macro).to eq(:belongs_to)
    end

    # good
    it 'saves successfully' do
      item = described_class.new(item_id: item1.id, category_id: category1.id)
      expect(item).to be_valid
    end
  end
end
