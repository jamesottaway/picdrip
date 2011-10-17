Given /^I am a Picdrip user$/ do
  visit :login do |page|
  	page.email = 'user@picdrip.com'
  	page.password = 'password'
  	page.login
  	page.notice.should == 'Signed in successfully.'
  end
end