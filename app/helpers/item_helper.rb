# frozen_string_literal: true

module ItemHelper
  def delete_association
    if (category = Category.find(params[:category_id].to_i)) && (item = category.items.find(params[:id].to_i))
      category.items.delete(item)
    end
    redirect_back(fallback_location: root_path)
  end

  def add_to_cart
    session[:cart] << params[:id].to_i unless session[:cart].include?(params[:id].to_i)
    redirect_back(fallback_location: root_path)
  end

  def remove_from_cart
    session[:cart].delete(params[:id].to_i)
    redirect_back(fallback_location: root_path)
  end
end
