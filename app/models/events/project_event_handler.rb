
class ProcessEventHandler

  def process event

    project = event.project
    type = event.type
    author = event.author

    milestone = Milestone.new
    milestone.author = author
    milestone.completed_date = Time.now
    milestone.status = :done
    milestone.people << project.people
    milestone.title = I18n.translate('events-strings.project.creation.title', project: project.name)
    milestone.description = I18n.translate('events-strings.project.creation.description', project: project.name, client: project.client)
    milestone.category = Category.find(1)
    milestone.tags << Tag.find(1)
    milestone.save!

  end

end