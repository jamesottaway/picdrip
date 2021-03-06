class User < ActiveRecord::Base
  has_many :albums
  
  devise :database_authenticatable, :rememberable, :validatable, :registerable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :flickr_auth_token, :twitter_auth_token, :twitter_auth_secret, :notifo_username

  def flickr_status
    flickr_authenticated? ? 'All systems are go!' : 'Still need to login...'
  end
  
  def persist_flickr_token token
    self.flickr_auth_token = token
    self.save!
  end
  
  def persist_twitter_token token
    self.twitter_auth_token = token.token
    self.twitter_auth_secret = token.secret
    self.save!
  end

  def flickr_authenticated?
    flickr_auth_token != nil
  end
end
