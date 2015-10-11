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

  def note_visibility_glyphicon(note)

    glyph = {every_body: "glyphicon-eye-open",
    mentors: "glyphicon-eye-close",
    me: "glyphicon-lock"}

    %{<div class="visibility glyphicon #{glyph[note.visibility.to_sym]}"></div>}.html_safe
  end
end
