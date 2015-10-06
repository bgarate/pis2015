module MilestoneHelper
  def milestone_short_info(m)
    %{<div class="short-info badge slide-on-hover-parent">
        <span class="icon glyphicon glyphicon-cloud"></span>
        <span>#{m.resources.count}</span>
        <span class="slide">documentos
        #{if can_modify_milestone? m.id
            link_to :controller => 'google', :action => 'adddriveview', :milestone_id => m.id do
              '<span class="action glyphicon glyphicon-plus"></span>'.html_safe
            end
          end}
        </span>
      </div>}.html_safe
  end
end
