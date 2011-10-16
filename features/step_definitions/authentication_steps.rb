Given /^I am not currently registered$/ do
  visit :login do |page|
    page.email = 'user@example.com'
    page.password = 'password'
    page.login
    page.alert.should == 'Invalid email or password.'
  end
end