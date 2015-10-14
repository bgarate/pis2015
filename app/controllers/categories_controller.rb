class CategoriesController < ApplicationController

  def index
    @category=Category.all
  end

  def new
    @category=Category.new
  end

  def create
    @category=Category.new(category_params)
    cat_name=Category.find_by_name @category.name
    if cat_name.nil?
      @category.save
      redirect_to @category
    else
      flash.alert= t('categories.new.exists')
      redirect_to '/categories/new'
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
