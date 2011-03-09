class Album < ActiveRecord::Base
  has_many :photos
  belongs_to :user
  
  validates :title, :presence => true
  validates :description, :presence => true
  validates :user_id, :presence => true
  
  accepts_nested_attributes_for :photos, :allow_destroy => true
end
