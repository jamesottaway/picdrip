class AddTwitterAuthTokenAndSecretToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :twitter_auth_token, :string
    add_column :users, :twitter_auth_secret, :string
  end

  def self.down
    remove_column :users, :twitter_auth_secret
    remove_column :users, :twitter_auth_token
  end
end
