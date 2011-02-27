class Photo < ActiveRecord::Base
  belongs_to :user
  
  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :s3_url, :uri => true
  validates :user_id, :presence => true
  
  def mark_as_sent
    self.uploaded = true and self.save
  end
end
