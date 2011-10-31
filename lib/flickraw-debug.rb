class FlickRaw::Flickr
	alias_method :call_original, :call
	alias_method :process_response_original, :process_response

	def call req, args={}, &block
		puts "-----\nREQUEST\n-----"
		puts build_args(args, req)
		puts '-----'
		call_original req, args, &block
	end

	def process_response req, http_response
		puts "----\nRESPONSE\n-----"
		puts http_response.inspect
		puts http_response.body
		puts '-----'
		process_response_original req, http_response
	end
end