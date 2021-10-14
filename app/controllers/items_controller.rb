# frozen_string_literal: true

class ItemsController < ApplicationController
  include AuthorizedPolicy
  include ItemHelper

  before_action :find_item, only: %i[show destroy edit update]

  before_action only: %i[destroy update edit create] do
    authorized_user(@item)
  end

  def index
    @items = finding_order
    @cate = find_category.name if params[:category_id] && !find_category.nil?
    redirect_to order_path(id: params[:order_id]) if params[:order_id]
  end

  def new
    @item = Item.new
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
    return unless params[:format] == '1' || params[:format] == '0'

    @item.status = params[:format]
    redirect_back(fallback_location: root_path) if @item.save
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
    @item.destroy!
    redirect_to items_path
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
    @item = Item.find(params[:id])
  end

  def find_category
    Category.find(params[:category_id])
  end

  def item_for_category
    Item.includes(:categories).where('categories.id' => params[:category_id].to_i)
  end

  def item_for_order
    Item.includes(:orders).where('orders.id' => params[:order_id].to_i)
  end
end
