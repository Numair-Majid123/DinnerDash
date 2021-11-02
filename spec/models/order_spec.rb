# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user1) { FactoryBot.create(:user) }

  context 'with invalid tests' do
    # bad
    it 'ensures user_id presence' do
      item = described_class.new(order_status: 0)
      expect(item.valid?).to eq(false)
    end
  end

  context 'with valid tests' do
    # association
    it 'has many items' do
      t = described_class.reflect_on_association(:items)
      expect(t.macro).to eq(:has_many)
    end

    # association
    it 'has one user' do
      t = described_class.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end

    # good
    it 'saves successfully' do
      item = described_class.new(order_status: 0, user_id: user1.id)
      expect(item).to be_valid
    end
  end
end
