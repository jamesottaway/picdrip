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
    FlickRaw.api_key = FLICKR_CONFIG['api_key']
    FlickRaw.shared_secret = FLICKR_CONFIG['api_secret']
    
    auth = flickr.auth.checkToken :auth_token => FLICKR_CONFIG['auth_token']
    
    flickr.upload_photo FILENAME, :title => photo.title, :description => photo.description
  end
  
  def mark_as_sent photo
    photo.mark_as_sent
  end
end