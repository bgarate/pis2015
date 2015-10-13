class NotesController < ApplicationController

  before_action :get_milestone, only: [:create, :destroy]
  skip_before_action :admin?, only: [:create]


  def get_milestone
    @milestone=Milestone.find(params[:milestone_id])
  end

  def create
    @note= @milestone.notes.create(notes_params.merge({author_id: current_person.id}))
    @milestone.updated_at = Time.now
    @milestone.save!
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