class CollectionsController < ApplicationController

  def new
    @templates = Template.all
  end

  def create
    @collection = Collection.new(collection_params)
    @collection.save

    if @collection.valid?
      flash.notice = "'#{collection_params[:title]}' " + t('messages.create.success')
    else
      flash.alert = "'#{collection_params[:title]}' " + t('messages.create.error')
    end

    redirect_to root_path
  end

  def collection_params
    params.require(:collection).permit(:title,:description, :icon)
  end
end