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

Then /^I should be able to view the Photo$/ do
  on :photo do |page|
  	page.browser.title.should =~ /^New Photo/
  	page.title.should == 'New Photo'
  	page.description.should == "Wow, it's so easy!"
  end
end