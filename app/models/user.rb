class User < ActiveRecord::Base
  has_many :albums
  
  devise :database_authenticatable, :rememberable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :flickr_auth_token, :twitter_auth_token, :twitter_auth_secret
  
  def persist_flickr_token token
    self.flickr_auth_token = token
    self.save!
  end
  
  def persist_twitter_token token
    self.twitter_auth_token = token.token
    self.twitter_auth_secret = token.secret
    self.save
  end
  
  def photos
    photos = []
    albums.each {|album| album.photos.each {|photo| photos << photo}}
    photos
  end
end
