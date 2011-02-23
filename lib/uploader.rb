class Uploader
  def go
    photo = Photo.next
    return if photo.nil?
    
    download_photo_to_tmp photo
    upload_photo photo
    mark_as_sent photo
  end
  
  def download_photo_to_tmp photo
  end

  def upload_photo photo
  end
  
  def mark_as_sent photo
  end
end