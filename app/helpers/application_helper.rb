module ApplicationHelper

  def milestone_status(milestone, *options)
    link_class = "milestone-status "
    options.each {|opt| link_class += opt.to_s + " "}
    link_class += " " + milestone.status
    link_to "", milestone_path(milestone, :milestone  => {:status => milestone.get_next_status}),
            :method => :put, class: link_class
  end

end
