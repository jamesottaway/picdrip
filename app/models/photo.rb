class Photo < ActiveRecord::Base
  belongs_to :album
  
  image_accessor :s3
  
  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :description, :presence => true
  validates :album_id, :presence => true
  
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
    s3.url
  end
  
  def small_square
    s3.thumb('100x100#').url
  end
  
  def medium
    s3.thumb('500x500').url
  end
end
