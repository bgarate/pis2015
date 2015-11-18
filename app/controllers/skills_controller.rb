class SkillsController < ApplicationController

  skip_before_action :admin?, only:[:show, :index]
  before_action :get_skill, only:[:edit, :update, :destroy]

  def get_skill
    @skill = Skill.find_by(id: params[:id])
  end

  def index
    @skills = Skill.where(validity: 'true').all.order('LOWER(name)')
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
    @skill=Skill.new(skill_params.except(:icon))
    if skill_params[:icon].present?
      preloaded = Cloudinary::PreloadedFile.new(skill_params[:icon])
      raise "Invalid upload signature" if !preloaded.valid?
      @skill.icon = preloaded.identifier
    end
    @skill.save
    if @skill.valid?
      flash.notice = "#{skill_params[:name]} " + t('messages.create.success')
    else
      flash.alert = "#{skill_params[:name]} " + t('messages.create.error')
    end
    redirect_to skills_path
  end


  def update
    if @skill.update(skill_params.except(:icon))
      if skill_params[:icon].present?
        preloaded = Cloudinary::PreloadedFile.new(skill_params[:icon])
        raise "Invalid upload signature" if !preloaded.valid?
        @skill.icon = preloaded.identifier
      end
      @skill.save
      flash.notice = "#{skill_params[:name]} " + t('messages.save.success')
      redirect_to skills_path
    else
      flash.alert = "#{skill_params[:name]} " + t('messages.save.error')
      render :edit
    end
  end

  def destroy
    name = @skill.name
    if @skill.person_skill.empty?
      @skill.destroy
      flash.notice = "#{name} " + t('messages.delete.success')
    else
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
