class Photo < ActiveRecord::Base
  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :s3_url, :uri => true
end
