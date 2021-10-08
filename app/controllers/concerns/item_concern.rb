# frozen_string_literal: true

module ItemConcern
  extend ActiveSupport::Concern

  def delete_association
    if (@category = Category.find(params[:format].to_i)) && (@item = @category.items.find(params[:item_id].to_i))
      @category.items.delete(@item)
    end
    redirect_back(fallback_location: root_path)
  end

  def add_to_cart
    session[:cart] << params[:item_id].to_i unless session[:cart].include?(params[:item_id].to_i)
  end

  def remove_from_cart
    session[:cart].delete(params[:item_id].to_i)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :status, :image, category_ids: [])
  end

  def finding_order
    if params[:category_id]
      item_for_category
    elsif params[:order_id]
      item_for_order
    else
      Item.all
    end
  end

  def find_item
    if Item.find_by(id: params[:id]).nil?
      flash[:alert] = 'item not found'
      redirect_to root_path
    else
      @item = Item.find_by(id: params[:id])
    end
  end

  def find_category
    if Category.find_by(id: params[:category_id]).nil?
      flash[:alert] = 'Category not found'
      nil
    else
      Category.find_by(id: params[:category_id])

    end
  end

  def item_for_category
    Item.includes(:categories).where('categories.id' => params[:category_id].to_i)
  rescue StandardError
    flash[:alert] = 'Category not found'
    redirect_to categories_path
  end

  def item_for_order
    Item.includes(:orders).where('orders.id' => params[:order_id].to_i)
  rescue StandardError
    flash[:alert] = 'Order not found'
    redirect_to orders_path
  end
end
