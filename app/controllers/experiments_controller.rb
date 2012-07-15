class ExperimentsController < ApplicationController
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
	
	def index
		# popular_photos = get_from_500px ["photos"], :feature => "popular"
		# @data = get_photo_details(popular_photos[:photos][0..2].map {|p| p[:id]})
	end

	def refresh_database
		
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
		json = MultiJson.decode(raw_data)
		recursive_symbolize_keys!(json)
		json
	end

	def recursive_symbolize_keys! hash
    hash.symbolize_keys!
    hash.values.select do |v|
    	recursive_symbolize_keys!(v) if v.is_a? Hash
    	v.each { |item| recursive_symbolize_keys!(item) } if v.is_a? Array
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
