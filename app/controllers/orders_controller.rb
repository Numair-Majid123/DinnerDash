# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :find_order, only: %i[show edit]

<<<<<<< HEAD
  def index
    @status_name = %w[Ordered Paid Cancelled Completed]
    @orders = filter_orders
  end

=======
>>>>>>> Added Order
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
<<<<<<< HEAD
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
      flash[:success] = 'Item created successfully'
    else
      flash[:error] = 'Item not created successfully'
=======
    else
      redirect_to new_user_session_path
>>>>>>> Added Order
    end
    redirect_back(fallback_location: root_path)
  end

  def index
    @status_name = %w[Ordered Paid Cancelled Completed]
    @orders = filter_orders
  end

  def edit
    @order.order_type = params[:format]
    @order.save
    redirect_back(fallback_location: root_path)
  end

  def destroy; end

<<<<<<< HEAD
=======
  def show
    @items = @order.items
    @total = 0
    @items.each do |item|
      @sub_total = item.price.to_i
      @total += @sub_total
    end
  end

>>>>>>> Added Order
  def decrease_quantity
    session[:hash][params[:id]] -= 1 if session[:hash][params[:id]] > 1
    total_calculate
    render new_order_path
  end

  def increase_quantity
    session[:hash][params[:id]] += 1 if session[:hash][params[:id]] < 100
    total_calculate
    render new_order_path
  end

<<<<<<< HEAD
  private

=======
>>>>>>> Added Order
  def total_calculate
    @total = 0
    @cart.each do |item|
      @sub_total = item.price.to_i * session[:hash][item.id.to_s].to_i
      @total += @sub_total
    end
  end

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
<<<<<<< HEAD
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
=======
    @order = Order.new(order_type: 'Ordered')
    @order.user_id = current_user.id
    @cart.each do |item|
      @order.order_items.new(item_id: item.id, quantity: session[:hash][item.id.to_s])
      flash[:alert] = if @order.save!
                        'order created successfully'
                      else
                        'Item not created successfully'
                      end
>>>>>>> Added Order
    end
  end

  def find_order
    @order = Order.find(params[:id])
  rescue StandardError => e
    flash[:alert] = e
    redirect_to :back
  end
end
