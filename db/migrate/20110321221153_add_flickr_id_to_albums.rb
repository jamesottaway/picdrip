class AddFlickrIdToAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :flickr_id, :string
  end

  def self.down
    remove_column :albums, :flickr_id
  end
end
