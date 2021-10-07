# frozen_string_literal: true

class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    @user.admin
  end

  def edit?
    new?
  end

  def destroy?
    new?
  end
end