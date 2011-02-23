task :upload_next_photo => :environment do
  desc "Upload the next photo in the queue"
  Uploader.new.go
end