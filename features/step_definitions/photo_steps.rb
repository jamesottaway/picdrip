When /^I upload a new photo$/ do
  on :album do |page|
  	page.new_photo
  end
  on :new_photo do |page|
    page.title = 'New Photo'
    page.description = "Wow, it's so easy!"
    page.photo = root_path + 'public/images/rails.png'
    page.create
    page.notice.should == 'Photo was successfully created.'
  end
end