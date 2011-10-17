class NewAlbumPage < BasePageClass
  text_field :title, :name => 'album[title]'
  text_field :description, :name => 'album[description]'
  button :create, :type => 'submit'
end