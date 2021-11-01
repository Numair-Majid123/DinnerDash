# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    new?
  end

  def new?
    @user&.admin
  end

  def update?
    new?
  end

  def edit?
    new?
  end

  def destroy?
    new?
  end

  def admin
    user.admin == true
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
