require 'open-uri'

class Uploader
  def go
    photo = Photo.next
    return if photo.nil?
    
    download_photo_to_tmp photo
    upload_photo photo
    mark_as_sent photo
  end
  
  def download_photo_to_tmp photo
    uri = URI.parse(photo.s3_url)
    filename = "#{APP_CONFIG['tmp_dir']}/tmp.jpg"
    
    open(uri) do |http|
      open(filename, "w") do |file|
        file.write(http.read)
       end
    end
  end

  def upload_photo photo
  end
  
  def mark_as_sent photo
  end
end