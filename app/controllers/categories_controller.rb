# frozen_string_literal: true

class CategoriesController < ApplicationController
  include AuthorizedPolicy

  before_action :find_category, only: %i[update edit destroy]

  before_action only: %i[destroy update edit] do
    authorized_user(@category)
  end

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(catergory_params)
    authorized_user(@category)
    if @category.save
      flash[:notice] = 'Category created successfully'
      redirect_to categories_path
    else
      flash[:alert] = error_message(@category)
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update(catergory_params)
      flash[:notice] = 'Category was updated successfully.'
      redirect_to categories_path
    else
      flash[:alert] = error_message(@category)
      render 'edit'
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = 'Category was deleted successfully.'
    else
      flash[:alert] = error_message(@category)
    end
    redirect_to categories_path
  end

  private

  def catergory_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
