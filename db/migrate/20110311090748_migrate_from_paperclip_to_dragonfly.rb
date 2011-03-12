class MigrateFromPaperclipToDragonfly < ActiveRecord::Migration
  def self.up
    Photo.all.each do |photo|
      next if photo.photo_file_name.nil?
      photo.s3_uid = photo.photo_file_name.sub(%r{^/}, '')
      photo.save
    end
  end

  def self.down
    Photo.all.each do |photo|
      next if photo.photo_file_name.nil?
      photo.photo_file_name = "/#{photo.s3_uid}"
      photo.save
    end
  end
end
