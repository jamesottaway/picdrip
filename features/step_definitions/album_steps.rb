Given /^I have created an Album$/ do
  create_album :title => 'Photo Management Cucumber',
    :description => 'This album is for the Cucumber features in photos.feature'
end

When /^I create an Album$/ do
  create_album :title => 'New Album',
    :description => 'Thanks Picdrip!'
end

Then /^I should be able to view the Album$/ do
  on :album do |page|
    page.browser.title.should =~ /^New Album/
    page.title.should == 'New Album'
    page.description.should == 'Thanks Picdrip!'
  end
end

def create_album opts
  on :albums do |page|
    page.new_album
  end
  on :new_album do |page|
    opts.each { |key, value| page.send "#{key}=", value }
    page.create
    page.notice.should == 'Album was successfully created.'
  end
end