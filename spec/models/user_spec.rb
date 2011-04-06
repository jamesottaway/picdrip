require 'spec_helper'

describe User do
  TOKEN = 'token'
  SECRET = 'secret'
  
  before do    
    @user = User.new :email => 'a@b.com', :password => '123456'
  end
  
  it 'should have many albums' do
    association = User.reflections[:albums]
    association.name.should == :albums
    association.macro.should == :has_many
  end

  it 'should persist the flickr token' do
    @user.should_receive(:flickr_auth_token=).with TOKEN
    @user.should_receive(:save!)
    @user.persist_flickr_token TOKEN
  end
  
  it 'should persist the twitter token' do
    token = stub 'twitter', :token => TOKEN, :secret => 'secret'
    @user.should_receive(:twitter_auth_token=).with TOKEN
    @user.should_receive(:twitter_auth_secret=).with SECRET
    @user.should_receive(:save!)
    @user.persist_twitter_token token
  end
end