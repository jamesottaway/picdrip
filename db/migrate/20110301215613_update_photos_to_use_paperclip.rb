class UpdatePhotosToUsePaperclip < ActiveRecord::Migration
  def self.up
    rename_column :photos, :s3_url, :photo_file_name
  end

  def self.down
    rename_column :photos, :photo_file_name, :s3_url
  end
end
