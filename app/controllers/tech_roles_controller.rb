class TechRolesController < ApplicationController

  skip_before_action :admin?, only:[:show, :index]
  before_action :get_tech_role, only:[:edit, :update, :destroy]

  def get_tech_role
    @techRole = TechRole.find_by(id: params[:id])
    unless @techRole && @techRole.validity?
      redirect_to tech_roles_path
    end
  end


  def index
    @techRoles=TechRole.where(validity: 'true').all.order('LOWER(name)')
  end

  def edit

  end

  def new
    @techRole = TechRole.new
  end

  def show
    redirect_to tech_roles_path
  end

  def create
    @techRole=TechRole.new(tech_role_params)
    @techRole.save
    if @techRole.valid?
      flash.notice = "#{tech_role_params[:name]} " + t('messages.create.success')
    else
      flash.alert = "#{tech_role_params[:name]} " + t('messages.create.error')
    end
    redirect_to tech_roles_path
  end

  def update
    if @techRole.update(tech_role_params)
      flash.notice = "#{tech_role_params[:name]} " + t('messages.save.success')
      redirect_to tech_roles_path
    else
      flash.alert = "#{tech_role_params[:name]} " + t('messages.save.error')
      render :edit
    end
  end

  def destroy
    if @techRole
      name = @techRole.name
      @techRole.validity = false
      @techRole.save
      flash.notice = "#{name} " + t('messages.delete.success')
    end
    redirect_to tech_roles_path
  end

  private
  def tech_role_params
    params.require(:tech_role).permit(:name)
  end


end