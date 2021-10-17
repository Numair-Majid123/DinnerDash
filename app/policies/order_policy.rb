# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  def all_orders?
    new?
  end
end
