class UserPage < BasePageClass
  direct_url 'http://localhost:9292/user'

  span :email, :id => 'email'
  span :flickr_status, :id => 'flickr_status'
  span :twitter_auth_token, :id => 'twitter_auth_token'
  span :twitter_auth_secret, :id => 'twitter_auth_secret'
  span :notifo_username, :id => 'notifo_username'

  link :authenticate_to_flickr, :text => 'Authenticate to Flickr'
end