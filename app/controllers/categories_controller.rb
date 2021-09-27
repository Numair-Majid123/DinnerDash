class CategoriesController < ApplicationController
  
  def new
    @category = Category.new

  end

  # def create
  #   @category = Category.new(category_params)
  #   if @category.save
  #     # redirect_to category_path(@category), notice: 'The category has been created successfully!'
  #     flash[:notice] = "Article was created successfully."
  #     redirect_to @category
  #   else
  #     render 'new'
  #   end
  # end

  def create
    @category = Category.new(catergory_params)
    if @category.save
      flash[:notice] = "Category created successfully"
      redirect_to categories_path
    else
      flash[:error] = "Category not created successfully"
      render 'new'
    end
  end


  def update
    @category = Category.find(params[:id])
    if @category.update(catergory_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to categories_path
    else
        render 'edit'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy!
    redirect_to categories_path
  end

  def show
    @category = Category.find(params[:id])
    @items = @category.items
  end

  def index
    @category = Category.all
  end

  private

  def catergory_params
    params.require(:category).permit(:name)
  end
end
