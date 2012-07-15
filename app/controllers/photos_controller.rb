class PhotosController < ApplicationController
	def index
		params[:offset] ||= 0
		@photos = Photo.limit(50).offset(params[:offset])
	end

	def show
		@photo = Photo.find(params[:id].to_i)
	end

	def ajax
		arr = Photo.order("focal_length DESC")
		arr = Photo.filter_focal_length(arr)
		arr = Photo.filter_iso(arr)
		arr = Photo.filter_shutter_speed(arr)
		arr = Photo.filter_aperture(arr)

		result = arr.sort_by { |item| diff_score(params, item) }.first
		render :json => result
	end

	def diff_score params, item
		score = 0
		unless params[:aperture].to_f == 0 and item[:aperture] == 0
			score += (params[:aperture].to_f-item[:aperture]).abs / [item[:aperture], params[:aperture].to_f].max
		end
		unless params[:focal_length].to_f == 0 and item[:focal_length] == 0
			score += (params[:focal_length].to_f-item[:focal_length]).abs / [item[:focal_length], params[:focal_length].to_f].max
		end
		unless params[:iso].to_f == 0 and item[:iso] == 0
			score += (params[:iso].to_f-item[:iso]).abs / [item[:iso], params[:iso].to_f].max
		end
		unless params[:shutter_speed].to_f == 0 and item[:shutter_speed] == 0
			score += (params[:shutter_speed].to_f-item[:shutter_speed]).abs / [item[:shutter_speed], params[:shutter_speed].to_f].max
		end
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
