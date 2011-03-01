CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")

APP_CONFIG = {:tmp_dir => CONFIG[:app][:tmp_dir]}
FLICKR_CONFIG = {:api_key => ENV['FLICKR_API_KEY'] || CONFIG[:flickr][:api_key], :api_secret => ENV['FLICKR_API_SECRET'] || CONFIG[:flickr][:api_secret]}
TWITTER_CONFIG = {:consumer_key => ENV['TWITTER_CONSUMER_KEY'] || CONFIG[:twitter][:consumer_key], :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'] || CONFIG[:twitter][:consumer_secret]}
S3_CONFIG = {:access_key_id => ENV['S3_ACCESS_KEY'] || CONFIG[:s3][:access_key], :secret_access_key => ENV['S3_ACCESS_SECRET'] || CONFIG[:s3][:access_secret], :bucket => CONFIG[:s3][:bucket], :root_url => CONFIG[:s3][:root_url]}