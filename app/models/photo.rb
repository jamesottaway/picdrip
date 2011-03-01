class Photo < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :photo,
        :storage => :s3,
        :s3_credentials => S3_CONFIG,
        :path => "/:filename"
  
  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :description, :presence => true
  validates :user_id, :presence => true
  
  def self.for user
    Photo.where(:user_id => user.id)
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
  
  def s3_url
    "#{S3_CONFIG[:root_url]}/#{S3_CONFIG[:bucket]}/#{photo_file_name}"
  end
  
  def owned_by? user
    self.user == user
  end
  
  def not_owned_by? user
    self.user != user
  end
end
