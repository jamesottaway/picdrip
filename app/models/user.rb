class User < ActiveRecord::Base
  has_many :photos
  
  devise :database_authenticatable, :rememberable

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
