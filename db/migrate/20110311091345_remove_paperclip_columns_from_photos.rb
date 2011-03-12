class RemovePaperclipColumnsFromPhotos < ActiveRecord::Migration
  def self.up
    remove_column :photos, :photo_file_name
  end

  def self.down
    add_column :photos, :photo_file_name, :string
  end
end
