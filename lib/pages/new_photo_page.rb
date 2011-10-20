class NewPhotoPage < BasePageClass
  text_field :title, :name => 'photo[title]'
  text_field :description, :name => 'photo[description]'
  file_field :photo, :name => 'photo[s3]'
  button :create, :type => 'submit'
end