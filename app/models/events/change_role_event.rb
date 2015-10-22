require 'person_event_handler'

class ChangeRoleEvent < Event

  attr_accessor :new_role, :old_role, :author, :person

  def fire
    @event_handler_class = PersonEventHandler
    super
  end

end