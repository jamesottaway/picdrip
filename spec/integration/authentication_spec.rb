require 'spec_helper'

describe 'authentication' do
  USERNAME = 'bob@example.com'
  PASSWORD = '123456'
  
  it 'should allow sign in' do
    User.create! :email => USERNAME, :password => PASSWORD
    
    visit new_user_session_path
    
    fill_in 'Email', :with => USERNAME
    fill_in 'Password', :with => PASSWORD
    click_button 'Sign in'
    
    current_path.should == root_path
    page.should have_content 'Signed in successfully.'
  end
  
  it 'should allow sign up' do
    visit new_user_registration_path
    
    fill_in 'Email', :with => USERNAME
    fill_in 'Password', :with => PASSWORD
    fill_in 'Password confirmation', :with => PASSWORD
    click_button 'Sign up'
    
    current_path.should == root_path
    page.should have_content 'You have signed up successfully.'
  end
end