class Photo < ActiveRecord::Base
  belongs_to :album
  
  image_accessor :s3
  has_attached_file :photo,
        :storage => :s3,
        :s3_credentials => S3_CONFIG,
        :path => "/:filename"
  
  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :description, :presence => true
  validates :album_id, :presence => true
  
  def user
    album.user
  end
  
  def mark_as_sent flickr_id
    self.uploaded = true
    self.flickr_id = flickr_id
    self.save
  end
  
  def uploaded?
    id = "(#{flickr_id})" if uploaded && flickr_id
    "#{uploaded.to_s.capitalize} #{id}"
  end
  
  def url
    photo.url
  end
end
