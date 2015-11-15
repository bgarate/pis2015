module TechnologyHelper

  def technology_icon id
    cl_image_tag(image_id_or_default(id))
  end

  def image_id_or_default id
    if id
      id
    else
      TechnologiesController::DEFAULT_ICON
    end
  end

end