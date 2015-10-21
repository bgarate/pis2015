require 'project_event_handler'

class ProjectEvent < Event

  attr_accessor :author, :project, :type

  def fire
    @event_handler_class = ProcessEventHandler
    super
  end

end