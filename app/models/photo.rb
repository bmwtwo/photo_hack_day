class Photo < ActiveRecord::Base
  # attr_accessible :title, :body
  def create_from_500px_full
  	Photo.create(
  		:id => 
	   	:name =>
	    :description =>
	    :times_viewed =>
	    :rating =>
	    :created_at =>
	    :category =>
	    :privacy =>
	    :width =>
	    :height =>
	    :votes_count =>
	    :favorites_count =>
	    :comments_count =>
	    :nsfw =>
	    :image_url =>
	    :user_id =>
  	)
  end

end
