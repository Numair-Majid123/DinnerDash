# frozen_string_literal: true

class CategoriesController < ApplicationController
  include CategoryConcern

  before_action :find_category, only: %i[update edit destroy]
  before_action :check_sign_in, only: %i[destroy edit update create new]
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(catergory_params)
    authorize @category
    if @category.save
      flash[:notice] = 'Category created successfully'
      redirect_to categories_path
    else
      flash[:error] = 'Category not created successfully'
      render 'new'
    end
  end

  def edit
    authorize @category
  end

  def update
    authorize @category
    if @category.update(catergory_params)
      flash[:notice] = 'Article was updated successfully.'
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    authorize @category
    @category.destroy!
    redirect_to categories_path
  end

  def check_sign_in
    return if user_signed_in?

    flash[:alert] = 'Not Authorized...'
    redirect_to categories_path
  end
end
