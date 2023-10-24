class CategoriesController < ApplicationController
  before_action :authenticate_user!  
  def index
    @categories = Category.where(author: current_user) 
  end

  def new
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category was successfully saved.'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
