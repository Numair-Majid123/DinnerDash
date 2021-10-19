# frozen_string_literal: true

class OrdersController < ApplicationController
  include OrderHelper

  before_action :find_order, only: %i[show edit]

  def index
    @orders = filter_orders
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

  def show;  end

  def edit
    @order.order_type = params[:status]
    if @order.save
      flash[:success] = 'Order Updated successfully'
    else
      flash[:error] = 'Order was not updated successfully'
    end
  end

  def destroy; end

  def decrease
    session[:hash][params[:id]] -= 1 if session[:hash][params[:id]] > 1
    @price = Item.find(params[:id]).price
    find_total
  end

  def increase
    session[:hash][params[:id]] += 1 if session[:hash][params[:id]] < 100
    @price = Item.find(params[:id]).price
    find_total
  end

  private

  def find_total
    @total = 0
    @cart.each do |item|
      @sub_total = item.price.to_i * session[:hash][item.id.to_s].to_i
      @total += @sub_total
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
        flash[:notice] = 'Order created successfully'
      else
        flash[:alert] = 'Order not created successfully'
      end
    end
  end

  def find_order
    @order = Order.find(params[:id])
  end
end
