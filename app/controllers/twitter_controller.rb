class TwitterController < ApplicationController
  def auth
    client = TwitterOAuth::Client.new(
        :consumer_key => TWITTER_CONFIG[:consumer_key],
        :consumer_secret => TWITTER_CONFIG[:consumer_secret]
    )
    
    request_token = client.request_token(:oauth_callback => TWITTER_CONFIG[:callback_url])
    session[:request_token] = request_token
    redirect_to request_token.authorize_url
  end

  def callback
    client = TwitterOAuth::Client.new(
        :consumer_key => TWITTER_CONFIG[:consumer_key],
        :consumer_secret => TWITTER_CONFIG[:consumer_secret]
    )
    
    request_token = session[:request_token]
    
    access_token = client.authorize(
      request_token.token,
      request_token.secret,
      :oauth_verifier => params[:oauth_verifier]
    )
    
    current_user.persist_twitter_token access_token
    redirect_to user_path
  end
end
