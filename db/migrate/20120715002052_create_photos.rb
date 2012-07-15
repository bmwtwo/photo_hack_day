class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.integer :id
	    t.integer :user_id
	    t.string :name
	    t.text :description
	    t.string :camera
	    t.string :lens
	    t.decimal :focal_length
	    t.decimal :shutter_speed
	    t.string :aperture
	    t.integer :times_viewed
	    t.decimal :rating
	    t.int :status
	    t.date :created_at
	    t.integer :category
	    t.string :location
	    t.boolean :privacy
	    t.decimal :latitude
	    t.decimal :longitude
	    t.date :taken_at
	    t.boolean :hi_res_uploaded
	    t.boolean :for_sale
	    t.integer :width
	    t.integer :height
	    t.integer :votes_count
	    t.integer :favorites_count
	    t.integer :comments_count
	    t.boolean :nsfw
	    t.integer :sales_count
	    t.date :for_sale_date
	    t.decimal :highest_rating
	    t.date :highest_rating_date
	    t.string :image_url
	    t.boolean :store_download
	    t.boolean :store_print

	    t.timestamps
    end
  end
end
