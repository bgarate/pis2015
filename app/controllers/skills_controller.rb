class SkillsController < ApplicationController

  skip_before_action :admin?, only:[:show, :index]
  before_action :get_skill, only:[:edit, :update, :destroy]

  def get_skill
    @skill = Skill.find_by(id: params[:id])
  end

  def index
    @skills = Skill.where(validity: 'true').paginate(:page => params[:page], :per_page => 10).order('LOWER(name)')
  end

  def edit

  end

  def new
    @skill = Skill.new
  end

  def show
    redirect_to skills_path
  end

  def create
    @skill=Skill.new(skill_params)
    @skill.save
    if @skill.valid?
      flash.notice = "#{skill_params[:name]} " + t('messages.create.success')
    else
      flash.alert = "#{skill_params[:name]} " + t('messages.create.error')
    end
    redirect_to skills_path
  end


  def update
    if @skill.update(skill_params)
      flash.notice = "#{skill_params[:name]} " + t('messages.save.success')
      redirect_to skills_path
    else
      flash.alert = "#{skill_params[:name]} " + t('messages.save.error')
      render :edit
    end
  end

  def destroy
    if @skill.person_skill.nil?
      @skill.destroy
    else
      name = @skill.name
      @skill.validity=false
      @skill.save
      flash.notice = "#{name} " + t('messages.delete.success')
    end
    redirect_to skills_path
  end

  private
  def skill_params
    params.require(:skill).permit(:name,:technical, :icon)
  end


end
