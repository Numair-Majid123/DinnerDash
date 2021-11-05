# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  def update_status?
    new?
  end
end
