class ChangeAlbumAndPhotoDescriptionsToText < ActiveRecord::Migration
  def self.up
    change_column :albums, :description, :text
    change_column :photos, :description, :text
  end

  def self.down
    change_column :albums, :description, :string
    change_column :photos, :description, :string
  end
end
