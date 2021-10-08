# frozen_string_literal: true

module OrderConcern
  extend ActiveSupport::Concern

  def decrease_quantity
    session[:hash][params[:id]] -= 1 if session[:hash][params[:id]] > 1
    @price = Item.find_by(id: params[:id]).price
    total_calculate
  end

  def increase_quantity
    session[:hash][params[:id]] += 1 if session[:hash][params[:id]] < 100
    @price = Item.find_by(id: params[:id]).price
    total_calculate
  end

  private

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
end
