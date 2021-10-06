# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :find_item, only: %i[show destroy edit update]

  def index
    @items = if params[:category_id]
               item_for_category
             elsif params[:order_id]
               item_for_order
             else
               Item.all
             end
    redirect_to order_path(id: params[:order_id]) if params[:order_id]
  end

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:success] = 'Item created successfully'
      redirect_to items_path
    else
      flash[:error] = 'Item not created successfully'
      render items_path
    end
  end

  def show; end

  def edit
    if params[:format] == '1' || params[:format] == '0'
      @item.status = params[:format]
      @item.save
      redirect_back(fallback_location: root_path)
    end
    authorize @item
  end

  def update
    if @item.update(item_params)
      flash[:notice] = 'Item was updated successfully.'
      redirect_to items_path
    else
      render 'edit'
    end
  end

  def destroy
    authorize @item
    @item.destroy!
    redirect_to items_path
  end

  def delete_association
    if (@category = Category.find(params[:format].to_i))
      @item = @category.items.find(params[:item_id].to_i)
      @category.items.delete(@item)
    end
    redirect_back(fallback_location: root_path)
  end

  def add_to_cart
    id = params[:item_id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_back(fallback_location: root_path)
  end

  def remove_from_cart
    id = params[:item_id].to_i
    session[:cart].delete(id)
    redirect_back(fallback_location: root_path)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :status, :image, category_ids: [])
  end

  def find_item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    flash[:alert] = e
    redirect_to :back
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
