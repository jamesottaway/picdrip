class User < ActiveRecord::Base
  has_many :photos
  
  devise :database_authenticatable, :rememberable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :flickr_auth_token, :twitter_auth_token, :twitter_auth_secret
  
  def next_photo
    photos.where(:uploaded => false).order(:created_at).first
  end
  
  def persist_flickr_token token
    self.flickr_auth_token = token
    self.save!
  end
  
  def owns? photo
    photos.include? photo
  end
end
