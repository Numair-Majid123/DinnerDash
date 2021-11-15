# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      def index
        items = Item.select('name', 'price', 'description')
        render json: items
      end

      def create_item
        item = Item.new(item_params)
        item.save
      end

      private

      def item_params
        params.require(:item).permit(:name, :description, :price, :status, :image, category_ids: [])
      end
    end
  end
end
