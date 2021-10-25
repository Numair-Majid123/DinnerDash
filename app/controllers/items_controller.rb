# frozen_string_literal: true

class ItemsController < ApplicationController
  include AuthorizedPolicy
  include ItemHelper
  include CalculateTotal

  before_action :find_item, only: %i[show destroy edit update]
  before_action :find_categories, only: %i[new edit]
  before_action only: %i[destroy update edit] do
    authorized_user(@item)
  end

  def index
    @items = finding_items
    @category = find_category.name if params[:category_id] && !find_category.nil?
    redirect_to order_path(id: params[:order_id]) if params[:order_id]
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    authorized_user(@item)
    set_status
    if @item.save
      flash[:notice] = 'Item created successfully'
      redirect_to item_path(@item)
    else
      flash[:alert] = error_message(@item)
      redirect_to items_path
    end
  end

  def show; end

  def edit
    return unless params[:status] == '1' || params[:status] == '0'

    @item.status = params[:status].to_i
    redirect_back(fallback_location: root_path) if @item.save
  end

  def update
    if @item.update(item_params)
      flash[:notice] = 'Item was updated successfully.'
      redirect_to item_path(@item)
    else
      flash[:alert] = error_message(@item)
      render 'edit'
    end
  end

  def destroy
    if @item.destroy
      flash[:notice] = 'Item was deleted successfully.'
    else
      flash[:alert] = error_message(@item)
    end
    redirect_to items_path
  end

  def update_quantity
    if params[:button_name] == 'decrease'
      decrease
    else
      increase
    end
    @price = Item.find(params[:id]).price
    find_total
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :status, :image, category_ids: [])
  end

  def set_status
    @item.status = if item_params[:status] == 'Available'
                     1
                   else
                     0
                   end
  end

  def finding_items
    if params[:category_id]
      item_for_category
    elsif params[:order_id]
      item_for_order
    else
      Item.all.page(params[:page]).per(5)
    end
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def find_category
    Category.find(params[:category_id])
  end

  def find_categories
    @categories = Category.all.collect { |x| [x.name, x.id] }
  end

  def item_for_category
    Item.includes(:categories).where('categories.id' => params[:category_id].to_i).page(params[:page]).per(5)
  end

  def item_for_order
    Item.includes(:orders).where('orders.id' => params[:order_id].to_i).page(params[:page]).per(5)
  end
end
