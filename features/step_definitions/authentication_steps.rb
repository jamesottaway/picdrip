Given /^I am not currently registered$/ do
  visit :login do |page|
    page.email = 'user@example.com'
    page.password = 'password'
    page.login
    page.alert.should == 'Invalid email or password.'
  end
end

When /^I register$/ do
  visit :register do |page|
    page.email = 'user@example.com'
    page.password = 'password'
    page.password_confirmation = 'password'
    page.register
    page.notice.should =~ /^You have signed up successfully./
  end
end