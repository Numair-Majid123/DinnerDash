# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryItem, type: :model do
  let(:category1) { FactoryBot.create :category }
  let(:item1) { FactoryBot.create :item }

  context 'with invalid tests' do
    it 'ensures item_id presence' do
      item = described_class.new(category_id: category1.id)
      expect(item.valid?).to eq(false)
    end

    it 'ensures category_id presence' do
      item = described_class.new(item_id: item1.id)
      expect(item.valid?).to eq(false)
    end
  end

  context 'with association' do
    it 'belongs to items' do
      t = described_class.reflect_on_association(:item)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'belongs to categories' do
      t = described_class.reflect_on_association(:category)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  context 'with valid tests' do
    it 'saves successfully' do
      item = described_class.new(item_id: item1.id, category_id: category1.id)
      expect(item).to be_valid
    end
  end
end
