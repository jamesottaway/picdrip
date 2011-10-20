require 'open-uri'
require 'flickraw-cached'
require 'twitter'
require 'notifo'

class Uploader
  def initialize
    FlickRaw.api_key = FLICKR_CONFIG[:api_key]
    FlickRaw.shared_secret = FLICKR_CONFIG[:api_secret]
    
    Twitter.configure do |t|
      t.consumer_key = TWITTER_CONFIG[:consumer_key]
      t.consumer_secret = TWITTER_CONFIG[:consumer_secret]
    end
  end
  
  def go
    Album.all.each do |album|
      @album = album
      @user = @album.user
      @photo = @album.next_photo
      
      next if @photo.nil?
      @filename = "#{APP_CONFIG[:tmp_dir]}/#{@photo.id}.jpg"
      
      download_to_tmp
      upload_to_flickr
      tweet
      push_to_notifo
    end
  end
  
  def download_to_tmp
    url = URI.parse(APP_CONFIG[:host] + @photo.url)
    download url, @filename
  end

  def upload_to_flickr
    @flickr = FlickRaw::Flickr.new
    auth = @flickr.auth.checkToken :auth_token => @user.flickr_auth_token
    
    flickr_id = @flickr.upload_photo @filename, :title => @photo.title, :description => @photo.description
    @photo.mark_as_sent flickr_id
    
    if @album.not_on_flickr?
      photoset = @flickr.photosets.create :title => @album.title, :description => @album.description, :primary_photo_id => flickr_id
      @album.persist_flickr_id photoset['id']
    else
      @flickr.photosets.addPhoto :photoset_id => @album.flickr_id, :photo_id => @photo.flickr_id
    end
  end
  
  def tweet
    Twitter.configure do |t|
      t.oauth_token = @user.twitter_auth_token
      t.oauth_token_secret = @user.twitter_auth_secret
    end
  
    info = @flickr.photos.getInfo(:photo_id => @photo.flickr_id)
    url = FlickRaw.url_short(info)
    
    Twitter.update("New Flickr Photo: #{@photo.title} #{url}")
  end
  
  def push_to_notifo
    notifo = Notifo.new NOTIFO_CONFIG[:username], NOTIFO_CONFIG[:secret]
    notifo.post @user.notifo_username, "Your photo '#{@photo.title}' from your #{@album.title} album was uploaded to Flickr"
  end
  
  private
  def download url, filename
    open(url) do |http|
      open(filename, "wb") do |file|
        file.write(http.read)
       end
    end
  end
end