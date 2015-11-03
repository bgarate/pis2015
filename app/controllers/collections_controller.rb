class CollectionsController < ApplicationController

  before_action :get_collection, only: [:show, :destroy, :generate]

  def get_collection
    @collection = Collection.find(params[:id])
    unless @collection
      redirect_to collection_path
    end
  end


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


  def show
    @templates = @collection.collection_templates
  end


  def destroy
    unless @collection.nil?
      title = @collection.title
      @collection.destroy
      flash.notice = "#{title} " + t('messages.delete.success')
    end
    redirect_to '/collections/'
  end


  def generate
    p = Person.find_by(id: params[:person_id])
    templates = @collection.collection_templates
    templates.each do |ct|
      t = Template.find(ct.template_id)
      days = ct.days
      if t && p
        m = Milestone.new
        m.title= t.title
        m.description= t.description
        m.category = t.category
        m.icon= t.icon
        m.tags = t.tags
        m.people<<(p)

        #AUTHOR
        m.author_id = current_user.person_id

        #Crear documento adjunto
        if t.resource
          u = current_user
          session = GoogleDrive.login_with_oauth(u.oauth_token)
          begin
            #traigo el archivo
            f = session.file_by_url(t.resource.url)
            #lo copio
            fuploaded = f.copy("#{m.title}")
            #agregar permisos a la gente asociada al hito
            m.people.each do |p|
              fuploaded.acl.push(
                  {:type => 'user', :value => p.email, :role => 'writer'})
            end

            #se logro encontrar el resource
            r = Resource.new
            r.doc_id= fuploaded.resource_id
            r.title= fuploaded.title
            r.url= fuploaded.human_url
            m.resources<<(r)

          rescue Google::APIClient::ClientError
            #no se logro encontrar el resorce
            driveerr = t(:driveerrormsj)
          rescue GoogleDrive::Error
            #url no es valida
            driveerr = t(:invalidurl)
          rescue URI::InvalidURIError
            #url no es valida
            driveerr = t(:invalidurl)
          end
        end

        m.save!

        if m.valid?
          if driveerr.nil?
            flash.notice = "'#{t.title}' " + t('messages.create.success')
          else
            flash.notice = "'#{t.title}' " + t('messages.create.success') + " \n(#{t(:driveerrormsj)}: #{driveerr})"
          end
        else
          flash.alert = "'#{t.title}' " + t('messages.create.error')
        end
      end
    end
    redirect_to :back
  end


  def collection_params
    params.require(:collection).permit(:title,:description, :icon)
  end

end