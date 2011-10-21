Given /^I have uploaded a Photo$/ do
  create_photo :title => 'Photo To Be Uploaded',
    :description => 'This should be uploaded by Picdrip',
    :photo => root_path + 'public/images/rails.png'
end

When /^I upload a new photo$/ do
  create_photo :title => 'New Photo',
    :description => "Wow, it's so easy!",
    :photo => root_path + 'public/images/rails.png'
end

Then /^I should be able to view the Photo$/ do
  on :photo do |page|
  	page.browser.title.should =~ /^New Photo/
  	page.title.should == 'New Photo'
  	page.description.should == "Wow, it's so easy!"
  end
end

def create_photo opts
  on :album do |page|
    page.new_photo
  end
  on :new_photo do |page|
    opts.each { |key, value| page.send "#{key}=", value }
    page.create
    page.notice.should == 'Photo was successfully created.'
  end
end