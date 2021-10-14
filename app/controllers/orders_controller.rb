# frozen_string_literal: true

class OrdersController < ApplicationController

  include OrderHelper
  before_action :find_order, only: %i[show edit]

  def index
    @status_name = %w[Ordered Paid Cancelled Completed]
    @orders = filter_orders
  end

  def new
    @cart.each do |item|
      session[:hash].merge!(item.id => 1)
    end
    total_calculate
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

  def show
    @items = @order.items
  end

  def edit
    @order.order_type = params[:format]
    if @order.save
      flash[:success] = 'Order Updated successfully'
    else
      flash[:error] = 'Order was not updated successfully'
    end
  end

  def destroy; end

  private

  def filter_orders
    case params[:format]
    when 'All'
      all_orders
    else
      other_filtered_orders
    end
  end

  def all_orders
    if current_user.admin
      Order.all
    else
      Order.where('user_id = ?', current_user.id)
    end
  end

  def other_filtered_orders
    if current_user.admin
      Order.where('order_type = ?', params[:format])
    else
      Order.where('user_id = ? AND order_type = ?', current_user.id, params[:format])
    end
  end

  def create_for_signed_in
    @order = Order.new
    @order.user_id = current_user.id
    save_order
  end

  def save_order
    @cart.each do |item|
      @order.order_items.new(item_id: item.id, quantity: session[:hash][item.id.to_s])
      if @order.save
        flash[:notice] = 'order created successfully'
      else
        flash[:alert] = 'Item not created successfully'
      end
    end
  end

  def find_order
    @order = Order.find(params[:id])
  end
end
