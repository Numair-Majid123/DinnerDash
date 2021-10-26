# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with validation tests' do
    # bad
    it 'ensures name presence' do
      user = described_class.new(email: 'sample@example.com').save
      expect(user).to eq(false)
    end

    # bad
    it 'ensures email presence' do
      user = described_class.new(name: 'sample').save
      expect(user).to eq(false)
    end

    # good
    it 'saves successfully' do
      user = described_class.new(name: 'sample', email: 'sample@example.com', password: '123456')
      expect(user).to be_valid
    end
  end
end
