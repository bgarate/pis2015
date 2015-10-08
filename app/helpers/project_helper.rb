module ProjectHelper
  def selected_technologies(p)
    select_tag(:technologies, options_from_collection_for_select(Technology.all, :id, :name, p.technologies.map {|t| t.id}),
                  :multiple => true, class: "chzn-select", 'data-placeholder'=> t('select_technologies'),
                  'style'=> 'width:100%')
  end
end