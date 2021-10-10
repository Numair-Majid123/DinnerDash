# frozen_string_literal: true

class OrdersController < ApplicationController
  include OrderConcern

  before_action :find_order, only: %i[show edit]
  before_action :check_sign_in


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
      session.delete(:hash)
      session.delete(:cart)
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

  def find_order
    if Order.find_by(id: params[:id]).nil?
      flash[:alert] = 'order not found'
      redirect_to orders_path('All')
    else
      @order = Order.find_by(id: params[:id])
    end
  end

  def check_sign_in
    return if user_signed_in?
  end

  def create_for_signed_in
    @order = Order.new
    @order.user_id = current_user.id
    save_order
  end

  def save_order
    @cart.each do |item|
      @order.order_items.new(item_id: item.id, quantity: session[:hash][item.id.to_s])
      if @order.save!
        flash[:notice] = 'order created successfully'
      else
        flash[:alert] = 'Item not created successfully'
      end
    end
  end

end
