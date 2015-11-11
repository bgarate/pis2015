module MilestoneHelper
  def note_visibility_glyphicon(note)

    glyph = {every_body: "glyphicon-eye-open",
    mentors: "glyphicon-eye-close",
    me: "glyphicon-lock"}

    %{<div class="visibility glyphicon #{glyph[note.visibility.to_sym]}"></div>}.html_safe
  end

  def milestone_icon(m)
    %{<span class="glyphicon #{m.icon}"></span>}
  end
end
