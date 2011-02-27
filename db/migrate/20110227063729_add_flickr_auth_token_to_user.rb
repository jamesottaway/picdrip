class AddFlickrAuthTokenToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :flickr_auth_token, :string
  end

  def self.down
    remove_column :users, :flickr_auth_token
  end
end
