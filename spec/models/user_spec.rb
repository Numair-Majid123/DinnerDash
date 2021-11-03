# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { FactoryBot.create(:user) }

  context 'with invalid tests' do
    it 'ensures name presence' do
      user = described_class.new(email: 'sample@example.com')
      expect(user.valid?).to eq(false)
    end

    it 'name should be unique' do
      user = described_class.new(name: user1.name, email: 'sample@example.com', password: '123456')
      expect(user).not_to be_valid
      expect(user.errors.messages[:name]).to eq(['Username already exists.'])
    end

    it 'name length should be more than 1' do
      user = described_class.new(name: 's', email: 'sample@example.com', password: '123456')
      expect(user).not_to be_valid
      expect(user.errors.messages[:name]).to eq(['Length must between 2-32'])
    end

    it 'name length should be more than 32' do
      user = described_class.new(name: 'sqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq', email: 'sample@example.com',
                                 password: '123456')
      expect(user).not_to be_valid
      expect(user.errors.messages[:name]).to eq(['Length must between 2-32'])
    end

    it 'ensures email presence' do
      user = described_class.new(name: 'sample')
      expect(user.valid?).to eq(false)
    end

    it 'Email format should be true' do
      user = described_class.new(name: 'sample', email: 'samplelecom', password: '123456')
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to eq(['is invalid', 'is invalid'])
    end
  end

  context 'with valid tests' do
    it 'saves successfully' do
      user = described_class.new(name: 'sample', email: 'sample@example.com', password: '123456')
      expect(user).to be_valid
    end
  end
end
