class PhotosController < ApplicationController
	def index
		@photos = Photo.limit(10)
	end

	def download_popular_photos
		
	end
end
