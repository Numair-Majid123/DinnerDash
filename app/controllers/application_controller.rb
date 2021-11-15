# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_session
  before_action :load_cart

  after_action :set_csrf_cookie

  def set_csrf_cookie
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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

  def record_not_found
    flash[:alert] = 'Record Not Found'
    redirect_to root_path
  end

  def error_message(record)
    record.errors.full_messages.join(', ')
  end
end
