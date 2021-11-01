# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with invalid tests' do
    # bad
    it 'ensures name presence' do
      user = described_class.new(email: 'sample@example.com')
      expect(user.valid?).to eq(false)
    end

    # bad
    it 'ensures email presence' do
      user = described_class.new(name: 'sample')
      expect(user.valid?).to eq(false)
    end
  end

  context 'with valid tests' do
    # good
    it 'saves successfully' do
      user = described_class.new(name: 'sample', email: 'sample@example.com', password: '123456')
      expect(user).to be_valid
    end
  end
end
