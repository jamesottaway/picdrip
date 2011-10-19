class NewPhotoPage < BasePageClass
  text_field :title, :name => 'photo[title]'
  text_field :description, :name => 'photo[description]'
  button :create, :type => 'submit'
  
  def photo= filename
  	file_field(:name, 'photo[s3]').set filename
  end
end