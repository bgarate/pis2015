class NotesController < ApplicationController

  before_action :get_milestone, only: [:create, :destroy]

  def get_milestone
    @milestone=Milestone.find(params[:milestone_id])
  end

  def create
    @note= @milestone.notes.create(notes_params)
    redirect_to @milestone
  end

  def destroy
    @note= @milestone.notes.find(params[:id])
    @note.destroy
    redirect_to @milestone
  end


  private
  def notes_params
    params.require(:note).permit(:text, :author_id, :visibility, :created_at, :updated_at, :milestone_id)

  end

end