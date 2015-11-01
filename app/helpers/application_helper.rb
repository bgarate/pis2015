module ApplicationHelper

  def milestone_status(milestone, *options)
    link_class = "milestone-status "
    options.each {|opt| link_class += opt.to_s + " "}
    link_class += " " + milestone.status
    link_to "", milestone_next_status_path(milestone.id), method: :post, class: link_class, data: { confirm: "#{t('milestones.mark_as_sure')}#{t("milestones.#{milestone.get_next_status_done_pend}")}?" }
  end
  def milestone_status_rej(milestone, *options)
    link_class = "milestone-rej-status "
    options.each {|opt| link_class += opt.to_s + " "}
    link_class += " " + milestone.status
    link_to "", milestone_next_status_rej_path(milestone.id), method: :post, class: link_class, data: { confirm: "#{t('milestones.mark_as_sure')}#{t("milestones.#{milestone.get_next_status_rej_pend}")}?" }
  end

  def milestone_highlight(milestone, *options)
    link_class = "milestone-highlight "
    options.each {|opt| link_class += opt.to_s + " "}
    link_class += " " + milestone.highlighted.to_s
    if milestone.highlighted
      link_to "", milestone_highlight_path(milestone.id), method: :post, class: link_class, data: { confirm: "#{t('milestones.mark_as_sure')}#{t('milestones.not_highlighted')}?" }
    else
      link_to "", milestone_highlight_path(milestone.id), method: :post, class: link_class, data: { confirm: "#{t('milestones.mark_as_sure')}#{t('milestones.highlighted')}?" }
    end
  end

end
