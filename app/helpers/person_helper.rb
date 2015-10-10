module PersonHelper

  def person_picture id
    if id
      cl_image_tag(@image_id)
    else
      cl_image_tag "lfblntfejcpmmkh0wfny.jpg"
    end
  end

end
