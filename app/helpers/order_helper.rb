# frozen_string_literal: true

module OrderHelper
  def decrease_quantity
    session[:hash][params[:id]] -= 1 if session[:hash][params[:id]] > 1
    @price = Item.find(params[:id]).price
    total_calculate
  end

  def increase_quantity
    session[:hash][params[:id]] += 1 if session[:hash][params[:id]] < 100
    @price = Item.find(params[:id]).price
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
end
