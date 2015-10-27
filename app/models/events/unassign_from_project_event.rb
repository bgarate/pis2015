require 'project_event_handler'

class UnassignFromProjectEvent < Event

  attr_accessor :author, :person, :project

  def fire
    @event_handler_class = ProjectEventHandler
    super
  end

end