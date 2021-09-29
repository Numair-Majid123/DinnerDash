class CheckoutController < ApplicationController
  def order_page
    if user_signed_in?
      @total = 0
      @cart.each do |item|
        @total = @total + item.price.to_i
      end
    else
      redirect_to new_user_session_path
    end
  end
end
