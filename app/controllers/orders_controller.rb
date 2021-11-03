# frozen_string_literal: true

class OrdersController < ApplicationController
  include OrderHelper
  include CalculateTotal

  before_action :find_order, only: %i[show update_status]

  def index
    @orders = filter_orders.page(params[:page]).per(5)
  end

  def new
    @cart.each do |item|
      session[:hash].merge!(item.id => 1)
    end
    find_total
  end

  def create
    if user_signed_in?
      create_for_signed_in
      %i[hash cart].each { |x| session.delete(x) }
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def show; end

  def update_status
    @order.order_status = (params[:status].to_i if params[:status].present?)

    if @order.save
      flash[:notice] = 'Order Updated successfully'
    else
      flash[:alert] = 'Order can not update successfully'
    end
  end

  private

  def create_for_signed_in
    @order = Order.new
    @order.user_id = current_user.id
    @order.order_status = 0
    save_order
  end

  def save_order
    @order.transaction do
      raise 'Error: Order can\'t save because cart is empty.' if @cart.empty?

      @order.save!
      @cart.each do |item|
        @order.order_items.create!(item_id: item.id, quantity: session[:hash][item.id.to_s])
      end
    end
  rescue StandardError => e
    flash[:alert] = e
  end

  def find_order
    @order = Order.find(params[:id])
  end
end
