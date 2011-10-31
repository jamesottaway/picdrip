require 'net/http'
require 'uri'

class Net::HTTP
  class << self
    alias start_original start

    def start address, *arg, &block
      if address.is_a? URI
  	    self.start_original address.host, address.port, *arg, &block
  	  else
  	    self.start_original address, *arg, &block
  	  end
    end
  end
end

flickr_fakr = URI.parse 'http://localhost:9000/'
FlickRaw.const_set :FLICKR_HOST, flickr_fakr

flickr_fakr_auth_url = FlickRaw.const_get(:AUTH_PATH).gsub('http://flickr.com', "http://localhost:9000")
FlickRaw.const_set :AUTH_PATH, flickr_fakr_auth_url
