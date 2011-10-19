class AlbumPage < BasePageClass
  span :title, :id => 'title'
  span :description, :id => 'description'
  link :new_photo, :text => 'New Photo'
end