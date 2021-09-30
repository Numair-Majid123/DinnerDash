# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :find_category, only: %i[update edit destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(catergory_params)
    if @category.save
      flash[:notice] = 'Category created successfully'
      redirect_to categories_path
    else
      flash[:error] = 'Category not created successfully'
      render 'new'
    end
  end

  def update
    if @category.update(catergory_params)
      flash[:notice] = 'Article was updated successfully.'
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def edit; end

  def destroy
    @category.destroy!
    redirect_to categories_path
  end

  def index
    @category = Category.all
  end

  private

  def catergory_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  rescue StandardError => e
    flash[:alert] = e
    redirect_to :back
  end
end
