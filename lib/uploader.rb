require 'open-uri'
require 'flickraw'

class Uploader
  FILENAME = "#{APP_CONFIG['tmp_dir']}/tmp.jpg"
  
  def go
    photo = Photo.next
    return if photo.nil?
    
    download_photo_to_tmp photo
    upload_photo photo
    mark_as_sent photo
  end
  
  def download_photo_to_tmp photo
    uri = URI.parse(photo.s3_url)
    
    
    open(uri) do |http|
      open(FILENAME, "w") do |file|
        file.write(http.read)
       end
    end
  end

  def upload_photo photo
    FlickRaw.api_key = APP_CONFIG['flickr_api_key']
    FlickRaw.shared_secret = APP_CONFIG['flickr_api_secret']
    
    auth = flickr.auth.checkToken :auth_token => APP_CONFIG['flickr_auth_token']
    
    flickr.upload_photo FILENAME, :title => photo.title, :description => photo.description
  end
  
  def mark_as_sent photo
  end
end