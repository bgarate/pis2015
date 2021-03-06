module ProjectHelper
  def selected_technologies(p)
    select_tag(:technologies, options_from_collection_for_select(Technology.where(validity: 'true').order('LOWER(name)'), :id, :name, p.technologies.map {|t| t.id}),
                  :multiple => true, class: "chzn-select", 'data-placeholder'=> t('project.technologies.select'),
                  'style'=> 'width:100%')
  end

  def project_status_glyphicon(project)

    glyph = {active: "glyphicon-play",
             inactive: "glyphicon-pause",
             finished: "glyphicon-ok"}

    %{<div class="glyphicon #{glyph[project.status.to_sym]}"></div>}.html_safe
  end

end