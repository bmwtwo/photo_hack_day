class Photo < ActiveRecord::Base
  # attr_accessible :title, :body
  def create_from_500px_full photo
  	photo.delete(:user)
  	Photo.create(photo)
  end

end
