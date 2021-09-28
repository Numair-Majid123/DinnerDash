class ItemsController < ApplicationController
  def new
    @item = Item.new
    @categories = Category.all
    @category_item = @item.category_items.new
  end

  def create

    @item = Item.new(params.require(:item).permit(:name, :description, :price, :status, category_ids: []))
    if @item.save
      flash[:success] = "Item created successfully"
      redirect_to items_path
    else
      flash[:error] = "Item not created successfully"
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(params.require(:item).permit(:name, :description, :price, :status, category_ids: []))
      flash[:notice] = "Item was updated successfully."
      redirect_to items_path
    else
        render 'edit'
    end
  end

  def edit
    @item = Item.find(params[:id])

  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy!
    redirect_to items_path
  end

  def show
  end

  def index
    @items = Item.all
  end
end
