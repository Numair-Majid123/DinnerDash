# frozen_string_literal: true

module OrderHelper
  def filter_orders
    case params[:status]
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
      Order.where('order_status = ?', params[:status])
    else
      Order.where('user_id = ? AND order_status = ?', current_user.id, params[:status])
    end
  end
end
