class PhotosController < ApplicationController
	def index
		params[:offset] ||= 0
		@photos = Photo.limit(50).offset(params[:offset])
	end

	def show
		@photo = Photo.find(params[:id].to_i)
	end

	def ajax
		render :json => ['test content']
	end

	def download_popular
		Photo.destroy_all

		(1..250).each do |i|
			puts "----------------------------------------"
			puts "ON PAGE #{i}"
			puts "----------------------------------------"

			popular_photos = get_from_500px ["photos"], :feature => "popular", :page => i
			photos = get_photo_details(popular_photos[:photos].map{ |p| p[:id] })
			photos.each do |photo|
				begin
					Photo.create_from_500px_full photo
				rescue Exception => e
					puts ""
					puts "ERRORRRRR!!!!! #{e}"
					puts ""
				end
			end
		end

		redirect_to photos_path
	end
end
