# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user1) { FactoryBot.create(:user) }

  context 'with invalid tests' do
    it 'ensures user_id presence' do
      item = described_class.new(order_status: 0)
      expect(item.valid?).to eq(false)
    end
  end

  context 'with association' do
    it 'has many items' do
      t = described_class.reflect_on_association(:items)
      expect(t.macro).to eq(:has_many)
    end

    it 'has many order_items' do
      t = described_class.reflect_on_association(:order_items)
      expect(t.macro).to eq(:has_many)
    end

    it 'belongs to user' do
      t = described_class.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  context 'with valid tests' do
    it 'saves successfully' do
      item = described_class.new(order_status: 0, user_id: user1.id)
      expect(item).to be_valid
    end

    it { is_expected.to define_enum_for(:order_status).with_values(Ordered: 0, Paid: 1, Cancelled: 2, Completed: 3) }
  end
end
