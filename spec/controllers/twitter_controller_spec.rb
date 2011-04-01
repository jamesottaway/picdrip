require 'spec_helper'

describe TwitterController do
  before do
    @client = stub 'client'
    @session = stub 'session'
    @request_token = stub 'request token'
    
    @key_and_secret = {:consumer_key => TWITTER_CONFIG[:consumer_key], :consumer_secret => TWITTER_CONFIG[:consumer_secret]}
    TwitterOAuth::Client.should_receive(:new).with(@key_and_secret).and_return @client

    @controller = TwitterController.new
    @controller.stub!(:session).and_return @session
  end
  
  it 'should build a request token and redirect to the auth url' do
    callback = {:oauth_callback => TWITTER_CONFIG[:callback_url]}
    auth_url = stub 'auth url'
    
    @client.should_receive(:request_token).with(callback).and_return @request_token
    @session.should_receive(:[]=).with(:request_token, @request_token)
    @request_token.should_receive(:authorize_url).and_return auth_url
    @controller.should_receive(:redirect_to).with auth_url
    
    @controller.auth
  end
  
  it 'should handle an oauth callback' do
    token = stub 'token'
    secret = stub 'secret'
    oauth_verifier = stub 'oauth_verifier'
    access_token = stub 'access token'
    user = stub 'current user'
    user_path = stub 'user path'
    
    @controller.stub!(:current_user).and_return user
    @controller.stub!(:user_path).and_return user_path
    
    @session.should_receive(:[]).with(:request_token).and_return @request_token
    @request_token.should_receive(:token).and_return token
    @request_token.should_receive(:secret).and_return secret
    @client.should_receive(:authorize).with(token, secret, :oauth_verifier => oauth_verifier).and_return access_token
    user.should_receive(:persist_twitter_token).with(access_token)
    @controller.should_receive(:redirect_to).with(user_path)
    
    @controller.params = {:oauth_verifier => oauth_verifier}
    @controller.callback
  end
end
