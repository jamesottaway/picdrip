class Photo < ActiveRecord::Base
  belongs_to :user
  
  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :s3_url, :uri => true
  validates :user_id, :presence => true
  
  def self.for user
    Photo.where(:user_id => user.id)
  end
  
  def mark_as_sent
    self.uploaded = true and self.save
  end
  
  def owned_by? user
    self.user == user
  end
  
  def not_owned_by? user
    self.user != user
  end
end
