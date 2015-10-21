class TemplatesController < ApplicationController

  def new
    u = User.find_by(id: session[:user_id])
    p = Person.find_by(id: u.person_id)
    @identifier =  u.person_id
    @person = Person.find_by(id: @identifier)

    #redirect_to '/people'
    @cats=Category.all.collect {|t| [t.name, t.id, 'isfeedback' => t.is_feedback]}
    @tags=Tag.all

    @redirect_url = request.headers["Referer"]
  end

  def create

    @template = Template.create(templates_params)

    @template.tag_ids = params[:tags]
    #CATEGORIES
    category=Category.find(params[:template][:category_id])
    @template.category=category

    @template.save!

    if @template.valid?
      flash.notice = "'#{templates_params[:title]}' " + t('messages.create.success')
    else
      flash.alert = "'#{templates_params[:title]}' " + t('messages.create.error')
    end

    if params[:redirect_url]
      redirect_to params[:redirect_url]
    else
      redirect_to root_path
    end
  end

  def templates_params
    params.require(:template).permit(:title,:description, :icon, :category_id, :created_at, :updated_at)
  end
end