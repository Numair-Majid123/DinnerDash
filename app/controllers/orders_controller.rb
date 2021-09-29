class OrdersController < ApplicationController
  def new
  end

  def create
    @order = Order.new(params.require(:cart).permit(:item))
    if @order.save
      flash[:success] = "Item created successfully"
      redirect_to root_path
    else
      flash[:error] = "Item not created successfully"
      render 
    end
  end

  def destroy
  end

  def show
  end
end
