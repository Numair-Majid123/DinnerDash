# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'with validation tests' do
    # bad
    it 'ensures name presence' do
      category = described_class.new(name: '').save
      expect(category).to eq(false)
    end

    # good
    it 'saves successfully' do
      category = described_class.new(name: 'sample').save
      expect(category).to eq(true)
    end

    # name length validation
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(32) }
  end
end
