# frozen_string_literal: true

module CalculateTotal
  def find_total
    @total = 0
    @cart.each do |item|
      @sub_total = item.price.to_i * session[:hash][item.id.to_s].to_i
      @total += @sub_total
    end
  end
end
