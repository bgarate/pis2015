
class PersonEventHandler

  def process(event)

    person = event.person

    milestone = Milestone.new
    milestone.author = event.author
    milestone.completed_date = Time.now
    milestone.status = :done
    milestone.people << person
    milestone.category = Category.get_or_create_history_category
    milestone.icon = milestone.category.icon

    milestone.title = I18n.translate("events-strings.person.#{event.type}.title",
                                     person: person.name, new_role: event.new_role.name)
    milestone.description = I18n.translate("events-strings.person.#{event.type}.description",
                                           person: person.name, new_role: event.new_role.name, old_role: event.old_role.name)

    milestone.save!

  end

end