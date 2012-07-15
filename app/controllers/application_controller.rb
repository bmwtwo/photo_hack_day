class ApplicationController < ActionController::Base
  	protect_from_forgery

  	require 'rubygems'
	# require 'oauth'
	require 'rest-client'
	require 'multi_json'
	require 'PP'

	CONSUMER_KEY = 'pGVlonYGLD206DIJEi5nwADa1ScsE6XTW5sZ7UME'
	CONSUMER_SECRET = 'lkBQONDoYtjfk0W1W9iyoII4NoQ7vm9GFR3IBXlV'
	USERNAME = ''
	PASSWORD = ''

	BASE_URL = 'https://api.500px.com/v1/'

	before_filter :set_cache_buster

	def set_cache_buster
		response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
	    response.headers["Pragma"] = "no-cache"
	    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
	end

  	def get_from_500px resource=nil, opts=nil
		query_url = BASE_URL + ""
		unless resource.nil?
			resource.each do |r|
				query_url.concat("#{r}/")
			end
		end
		query_url.concat "?consumer_key=#{CONSUMER_KEY}"

		unless opts.nil?
			opts.each do |opt, value|
				query_url.concat("&#{opt}=#{value}")
			end
		end

		raw_data = RestClient.get query_url

		# puts query_url
		puts raw_data.code

		json = MultiJson.decode(raw_data)

		recursive_symbolize_keys!(json)
		json
	end

	def recursive_symbolize_keys! hash
	    hash.symbolize_keys!
	    hash.values.select do |v|
	    	recursive_symbolize_keys!(v) if v.is_a? Hash
	    	v.each { |item| recursive_symbolize_keys!(item) } if (v.is_a? Array and v.first.is_a? Hash)
	    end
	  end

  	def get_photo_details photo_ids
  		photos = []
  		photo_ids.each do |id|
  			photos << (get_from_500px ["photos", id])[:photo]
  		end
  		photos
  	end
end
