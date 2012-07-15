class ExperimentsController < ApplicationController
	
	def index
		# popular_photos = get_from_500px ["photos"], :feature => "popular"
		# @data = get_photo_details(popular_photos[:photos][0..2].map {|p| p[:id]})

		@range = {}
		@range[:focal_length] = Photo.get_distinct_focal_lengths
		@range[:iso] = Photo.get_distinct_isos
		@range[:shutter_speed] = Photo.get_distinct_shutter_speeds
		@range[:aperture] = Photo.get_distinct_apertures
	end
end
