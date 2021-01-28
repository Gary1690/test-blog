class CategoriesController < ApplicationController

  def index 

  end

  def new 

  end 

  def show

  end 
  
  def create 
    @category = Category.new(category_params)
    if(@category.save)
      flash[:notice] = "Category saved successfully "
      redirect_to category_path(@category)
    else 
      flash[:alert] = @category.errors.full_messages
      render 'new'
    end
  end 

  private 
  def category_params
    params.require(:category).permit(:name)
  end
end
