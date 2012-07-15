class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.integer :id
	    t.string :name
	    t.text :description
	    t.integer :times_viewed
	    t.decimal :rating
	    t.date :created_at
	    t.integer :category
	    t.boolean :privacy
	    t.integer :width
	    t.integer :height
	    t.integer :votes_count
	    t.integer :favorites_count
	    t.integer :comments_count
	    t.boolean :nsfw
	    t.string :image_url
	    t.integer :user_id

	    t.timestamps
    end
  end
end
