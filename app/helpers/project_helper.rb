module ProjectHelper
  def selected_technologies(p)
    select_tag(:technologies, options_from_collection_for_select(Technology.all.order('LOWER(name)'), :id, :name, p.technologies.map {|t| t.id}),
                  :multiple => true, class: "chzn-select", 'data-placeholder'=> t('project.technologies.select'),
                  'style'=> 'width:100%')
  end
end