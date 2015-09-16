class PersonController < ApplicationController
  def index
  end

	def add_milestones_dates
		#TODO: Debo checkear si soy mentor?
		#TODO: Como consigo el milestone para setearle la fecha de fin?
		
		milestone = Milestone.find_by(id: params[:milestone_id])
		milestone.update(due_date: params[:due_date]) if milestone
	end
end
