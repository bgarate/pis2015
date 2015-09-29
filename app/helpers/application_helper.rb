module ApplicationHelper

  def milestone_status(milestone, *options)
    link_class = "milestone-status "
    options.each {|opt| link_class += opt.to_s + " "}
    link_class += " " + milestone.status
    link_to "", milestone_next_status_path(milestone.id), method: :post, class: link_class
  end

end
