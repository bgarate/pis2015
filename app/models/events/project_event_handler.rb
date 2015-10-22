
class ProcessEventHandler

  def process(event)

    project = event.project
    person = event.person

    milestone = Milestone.new
    milestone.author = event.author
    milestone.completed_date = Time.now
    milestone.status = :done
    milestone.people << person
    milestone.category = Category.get_or_create_history_category
    milestone.icon = milestone.category.icon

    milestone.title = I18n.translate("events-strings.project.#{event.type.to_s}.title", name: person.name.titleize, project: project.name)
    milestone.description = I18n.translate("events-strings.project.#{event.type.to_s}.description", name: person.name.titleize,
                                           project: project.name, client: project.client)

    milestone.save!

  end

end