module PersonHelper

  def person_picture id
      cl_image_tag(imageIdOrDefault(id))
  end

  def imageIdOrDefault(id)
    if id
      id
    else
      PeopleController::DEFAULT_IMAGE_ID
    end
  end

end
