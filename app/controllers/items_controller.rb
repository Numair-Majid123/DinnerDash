# frozen_string_literal: true

class ItemsController < ApplicationController
  include ItemConcern

  before_action :find_item, only: %i[show destroy edit update]
  before_action :check_sign_in, only: %i[destroy edit update create new]

  def index
    @items = finding_order
    @cate = find_category.name if params[:category_id] && !find_category.nil?
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
      redirect_back(fallback_location: root_path) if @item.save
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

  def check_sign_in
    return if user_signed_in?

    flash[:alert] = 'Not Authorized...'
    redirect_to items_path
  end
end
