Given /^I am a Picdrip user$/ do
  visit :login do |page|
  	page.email = 'user@picdrip.com'
  	page.password = 'password'
  	page.login
  	page.notice.should == 'Signed in successfully.'
  end
end

When /^I create an Album$/ do
  on :albums do |page|
  	page.new_album
  end
  on :new_album do |page|
  	page.title = 'New Album'
  	page.description = 'Thanks Picdrip!'
  	page.create
  	page.notice.should == 'Album was successfully created.'
  end
end