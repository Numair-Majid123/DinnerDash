# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      def index
        orders = Order.includes(:user).pluck('users.name', 'users.email', 'orders.created_at', 'orders.updated_at',
                                             'orders.order_status')
        render json: orders
      end
    end
  end
end
