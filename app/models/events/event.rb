class Event

  attr_accessor :type

  def initialize args
    args.each {|k,v| send("#{k}=",v)}
  end

  def fire
    if @event_handler_class == nil
      raise "Event handler not set"
    else
      handler = @event_handler_class.new
      handler.process self
    end
  end

  def type
    self.class.name.underscore
  end

end