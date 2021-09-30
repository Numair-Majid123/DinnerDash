# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :find_item, only: %i[show destroy edit update]

  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_back(fallback_location: root_path)
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_back(fallback_location: root_path)
  end

  def new
    @item = Item.new
    @categories = Category.all
    @category_item = @item.category_items.new
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

  def update
    if @item.update(item_params)
      flash[:notice] = 'Item was updated successfully.'
      redirect_to items_path
    else
      render 'edit'
    end
  end

  def edit; end

  def destroy
    @item.destroy!
    redirect_to items_path
  end

  def show; end

  def index
    @items = if params[:category_id]
               if (@category = Category.find_by(id: params[:category_id].to_i))
                 Category.find_by(id: params[:category_id]).items
               else
                 flash[:alert] = 'Category not found'
                 redirect_to categories_path
               end
             else
               Item.all
             end
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :status, :image, category_ids: [])
  end

  def find_item
    @item = Item.find(params[:id])
  rescue StandardError => e
    flash[:alert] = e
    redirect_to :back
  end
end
