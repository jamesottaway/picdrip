class User < ActiveRecord::Base
  has_many :photos
  
  devise :database_authenticatable, :rememberable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def next_photo
    photos.where(:uploaded => false).order(:created_at).first
  end
  
  def owns? photo
    photos.include? photo
  end
end
