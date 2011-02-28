require 'open-uri'
require 'flickraw-cached'

class Uploader
  def go
    User.all.each do |user|
      photo = user.next_photo
      return if photo.nil?
      
      @filename = "#{APP_CONFIG['tmp_dir']}/#{photo.id}.jpg"
    
      download_photo_to_tmp photo
      upload_photo photo, user
      mark_as_sent photo
    end
  end
  
  def download_photo_to_tmp photo
    uri = URI.parse(photo.s3_url)
    
    open(uri) do |http|
      open(@filename, "w") do |file|
        file.write(http.read)
       end
    end
  end

  def upload_photo photo, user
    flickr = FlickRaw::Flickr.new
    FlickRaw.api_key = FLICKR_CONFIG['api_key']
    FlickRaw.shared_secret = FLICKR_CONFIG['api_secret']
    
    auth = flickr.auth.checkToken :auth_token => user.flickr_auth_token
    
    flickr_id = flickr.upload_photo @filename, :title => photo.title, :description => photo.description
    photo.mark_as_sent flickr_id
  end
  
  def mark_as_sent photo
    photo.mark_as_sent
  end
end