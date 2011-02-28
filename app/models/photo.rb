class Photo < ActiveRecord::Base
  belongs_to :user
  
  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :description, :presence => true
  validates :s3_url, :presence => true, :uri => true
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
  
  def owned_by? user
    self.user == user
  end
  
  def not_owned_by? user
    self.user != user
  end
end
