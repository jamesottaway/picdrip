class Album < ActiveRecord::Base
  has_many :photos
  belongs_to :user
  
  validates :title, :presence => true
  validates :description, :presence => true
  validates :user_id, :presence => true
  
  accepts_nested_attributes_for :photos, :allow_destroy => true
  
  def next_photo
    photos.where(:uploaded => false).order(:created_at).first
  end
  
  def on_flickr?
    flickr_id
  end
  
  def not_on_flickr?
    !on_flickr?
  end
  
  def persist_flickr_id photoset_id
    self.flickr_id = photoset_id
    self.save
  end
end
