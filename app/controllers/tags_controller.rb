class TagsController < ApplicationController

  before_action :get_tag, only: [:show, :edit, :update, :destroy]

  def get_tag
    @tag = Tag.find_by(id: params[:id])
  end

  def index
    @tags=Tag.all
  end

  def edit
  end

  def new
  end

  def show
    if @tag
      #nombre
      @name = @tag.name
    else
      redirect_to root_path
    end
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.save
    if @tag.valid?
      flash.notice = "Tag #{tag_params[:name]} " + t('messages.create.success')
      redirect_to '/tags'
    else
      flash.alert = "Tag #{tag_params[:name]} " + t('messages.create.error')
      redirect_to '/tags/new'
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to '/tags'
    else
      render :edit
    end
  end

  def destroy
    if @tag
      @tag.destroy
    end
    redirect_to '/tags'
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end


end