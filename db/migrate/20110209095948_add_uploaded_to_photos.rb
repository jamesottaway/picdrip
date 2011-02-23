class AddUploadedToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :uploaded, :boolean, :default => false
  end

  def self.down
    remove_column :photos, :uploaded
  end
end
