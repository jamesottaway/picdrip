class AddDragonflyColumnsToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :s3_uid, :string
  end

  def self.down
    remove_column :photos, :s3_uid
  end
end
