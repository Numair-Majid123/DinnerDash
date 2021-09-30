# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_session
  before_action :load_cart

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:display_name, :name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:display_name, :name, :email, :password, :current_password)
    end
  end

  private

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Item.find(session[:cart])
  end
end
