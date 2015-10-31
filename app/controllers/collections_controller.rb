class CollectionsController < ApplicationController

  def new
    @templates = Template.all
  end

  def create
    @collection = Collection.new(collection_params)

    @collection.save

    template = Template.find(params[:template])
    days = params[:days]
    elem = CollectionTemplate.new(collection: @collection, template: template, days: days)
    @collection.collection_templates << elem
    @collection.save

    if @collection.valid?
      flash.notice = "'#{collection_params[:title]}' " + t('messages.create.success')
    else
      flash.alert = "'#{collection_params[:title]}' " + t('messages.create.error')
    end

    redirect_to root_path
  end

  def index
    @collections = Collection.all
    respond_to do |f|
      f.json { render json: name_and_path(@collections)}
      f.html { render }
    end
  end

  def collection_params
    params.require(:collection).permit(:title,:description, :icon)
  end

end