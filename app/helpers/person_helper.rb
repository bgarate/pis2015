module PersonHelper

  def person_picture id
      cl_image_tag(image_id_or_default(id))
  end

  def image_id_or_default id
    if id
      id
    else
      PeopleController::DEFAULT_IMAGE_ID
    end
  end

end
