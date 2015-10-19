class TechRolesController < ApplicationController

  def index
    @techRoles=TechRole.all
  end

  def edit
    @techRole = TechRole.find_by(id: params[:id])
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
    @techRole = TechRole.find_by(id: params[:id])
    if @techRole.update(tech_role_params)
      flash.notice = "#{tech_role_params[:name]} " + t('messages.save.success')
      redirect_to tech_roles_path
    else
      flash.alert = "#{tech_role_params[:name]} " + t('messages.save.error')
      render :edit
    end
  end

  def destroy
    @techRole = TechRole.find_by(id: params[:id])
    if @techRole
      @techRole.destroy
    end
    redirect_to tech_roles_path
  end

  private
  def tech_role_params
    params.require(:tech_role).permit(:name)
  end


end