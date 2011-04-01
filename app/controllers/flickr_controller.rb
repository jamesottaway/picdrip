require 'flickraw-cached'

class FlickrController < ApplicationController
  before_filter :authenticate_user!
  
  FlickRaw.api_key = FLICKR_CONFIG[:api_key]
  FlickRaw.shared_secret = FLICKR_CONFIG[:api_secret]
  
  def auth
    frob = flickr.auth.getFrob
    redirect_to FlickRaw.auth_url :frob => frob, :perms => 'write'
  end

  def callback
    flickr = FlickRaw::Flickr.new
    auth = flickr.auth.getToken :frob => params[:frob]
    login = flickr.test.login
    current_user.persist_flickr_token auth.token
    redirect_to user_path
  end
end
