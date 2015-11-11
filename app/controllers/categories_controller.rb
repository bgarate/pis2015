class CategoriesController < ApplicationController

  before_action :get_category, only: [:edit,:update]

  def index
    @category = Category.paginate(:page => params[:page], :per_page => 10).order('LOWER(name)')
  end

  def new
    @category=Category.new
  end

  def get_category
    @category=Category.find(params[:id])
  end

  def create
    @category=Category.new(category_params)
    cat_name=Category.find_by_name @category.name
    if cat_name.nil?
      @category.status = 0
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


  def edit
  end


  def update
    if @category.update_attributes(category_params)
      redirect_to '/categories'
    else
      render :edit
    end
  end

  def destroy

   cat = Category.find_by(id: params[:category_id])
   unless cat.nil?
      name = cat.name
      if (cat.has_milestones?)
        cat.status = 1
        cat.save
      else
        cat.destroy
      end

      flash.notice = "#{name} " + t('messages.delete.success')
    end
    redirect_to categories_path
  end

  def activate

    @cate = Category.find_by(id: params[:id] || params[:category_id])
    @cate.status = 0
    @cate.save!
    redirect_to :back
  end

  private
  def category_params
    params.require(:category).permit(:name, :icon, :created_at, :updated_at,:is_feedback)
  end


end
