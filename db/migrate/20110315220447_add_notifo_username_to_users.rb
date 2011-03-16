class AddNotifoUsernameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :notifo_username, :string
  end

  def self.down
    remove_column :users, :notifo_username
  end
end
