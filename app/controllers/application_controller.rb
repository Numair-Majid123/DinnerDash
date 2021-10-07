# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_session
  before_action :load_cart

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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
    session[:hash] ||= {}
    session[:hash].default = 1
  end

  def load_cart
    @cart = Item.find(session[:cart])
  rescue StandardError
    flash[:alert] = "Session cart can't create. Please restart your app"
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized.'
    redirect_to(request.referer || root_path)
  end

  def after_sign_in_path_for(_resource)
    if session[:cart].empty?
      root_path
    else
      flash[:notice] = 'Your order is ready please checkout again'
      new_order_path
    end
  end
end
