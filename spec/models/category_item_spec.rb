require 'rails_helper'

RSpec.describe CategoryItem, type: :model do
  context 'with validation tests' do
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
  end
end
