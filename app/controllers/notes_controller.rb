class NotesController < ApplicationController

  skip_before_action :loged?, only:[:callback,:unregistered]
  skip_before_action :admin?

  def create
    @milestone= Milestone.find(params[:milestone_id])
    @note= @milestone.notes.create(notes_params)
    redirect_to @milestone
  end

  def destroy
    @milestone= Milestone.find(params[:milestone_id])
    @note= @milestone.notes.find(params[:id])
    @note.destroy
    redirect_to @milestone
  end


  private
  def notes_params
    params.require(:note).permit(:text, :author_id, :visibility, :created_at, :updated_at, :milestone_id)

  end

end