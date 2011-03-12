CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")

APP_CONFIG = {:tmp_dir => CONFIG[:app][:tmp_dir], :host => ENV['HOST'] || CONFIG[:app][:host]}
FLICKR_CONFIG = {:api_key => ENV['FLICKR_API_KEY'] || CONFIG[:flickr][:api_key], :api_secret => ENV['FLICKR_API_SECRET'] || CONFIG[:flickr][:api_secret]}
TWITTER_CONFIG = {:consumer_key => ENV['TWITTER_CONSUMER_KEY'] || CONFIG[:twitter][:consumer_key], :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'] || CONFIG[:twitter][:consumer_secret], :callback_url => CONFIG[:twitter][:callback_url]}
