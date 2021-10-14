# frozen_string_literal: true

module AuthorizedPolicy
  extend ActiveSupport::Concern

  def authorized_user(check_policy)
    authorize check_policy
  end

  def check_signed_in()

  end
end
