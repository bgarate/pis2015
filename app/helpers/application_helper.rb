module ApplicationHelper

  def milestone_status(milestone, *options)
    link_class = "milestone-status "
    options.each {|opt| link_class += opt.to_s + " "}
    link_class += " " + milestone.status
    link_to "", milestone_next_status_path(milestone.id), method: :post, class: link_class, data: { confirm: "#{t('milestones.mark_as_sure')} #{t("milestones.#{milestone.get_next_status_done_pend}")}?" }
  end
  def milestone_status_rej(milestone, *options)
    link_class = "milestone-rej-status "
    options.each {|opt| link_class += opt.to_s + " "}
    link_class += " " + milestone.status
    link_to "", milestone_next_status_rej_path(milestone.id), method: :post, class: link_class, data: { confirm: "#{t('milestones.mark_as_sure')} #{t("milestones.#{milestone.get_next_status_rej_pend}")}?" }
  end

  def user_admin(user, *options)
    link_to "CAMBIAR", person_switch_admin_path(user.id), method: :post,  data: { confirm: "#{t('people.admin.mark_as_sure')}#{t("people.admin.#{user.get_next_admin_value}")}" }
  end


end
