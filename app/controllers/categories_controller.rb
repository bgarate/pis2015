class CategoriesController < ApplicationController

  def index
    @category=Category.all
  end

  def new
    @category=Category.new
  end

  def create
    @category=Category.new(category_params)
    if Category.exists? Category.find_by_name(@category.name)
      flash.alert= t('categories.new.exists')
      redirect_to '/categories/new'
    else
      @category.save
      redirect_to @category
    end
  end

  def show
    redirect_to categories_path
    #@category=Category.find(params[:id])
  end

  private
  def category_params
    params.require(:category).permit(:name, :icon, :created_at, :updated_at)
  end

end
