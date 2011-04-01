require 'spec_helper'

describe FlickrController do
  before do
    @flickr_auth = stub 'flickr auth'
    @flickr_test = stub 'flickr test'
    @frob = stub 'frob'
    
    flickr = stub 'flickr'
    flickr.stub!(:auth).and_return @flickr_auth
    flickr.stub!(:test).and_return @flickr_test
    
    @controller = FlickrController.new
    FlickRaw::Flickr.should_receive(:new).and_return flickr
  end
  
  it 'should get a frob and redirect to the auth url' do
    auth_url = stub 'auth url'
    
    @flickr_auth.should_receive(:getFrob).and_return @frob
    FlickRaw.should_receive(:auth_url).with({:frob => @frob, :perms => 'write'}).and_return auth_url
    @controller.should_receive(:redirect_to).with auth_url
    
    @controller.auth
  end
  
  it 'should handle the callback from flickr' do
    auth = stub 'auth'
    login = stub 'test login'
    token = stub 'token'
    user = stub 'user'
    user_path = stub 'user path'
    
    auth.stub!(:token).and_return token
    @controller.stub!(:current_user).and_return user
    @controller.stub!(:user_path).and_return user_path
    
    @flickr_auth.should_receive(:getToken).with(:frob => @frob).and_return auth
    @flickr_test.should_receive(:login).and_return login
    user.should_receive(:persist_flickr_token).with token
    @controller.should_receive(:redirect_to).with user_path
    
    @controller.params = {:frob => @frob}
    @controller.callback
  end
end
