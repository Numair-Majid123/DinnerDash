# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user1) { FactoryBot.create(:user) }

  context 'with invalid tests' do
    # bad
    it 'ensures name presence' do
      category = described_class.new(name: '')
      expect(category.valid?).to eq(false)
    end
  end

  context 'with valid tests' do
    # association
    it 'have many items' do
      t = described_class.reflect_on_association(:items)
      expect(t.macro).to eq(:has_many)
    end

    # good
    it 'saves successfully' do
      category = described_class.new(name: user1.name)
      expect(category.valid?).to eq(true)
    end

    # name length validation
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(32) }
  end
end
