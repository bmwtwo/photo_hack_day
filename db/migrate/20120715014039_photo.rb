class Photo < ActiveRecord::Migration
  def change
  	change_table :photos do |t|
  		t.string :iso
  		t.remove :focal_length, :shutter_speed
  		t.string :focal_length
  		t.string :shutter_speed
  	end
  end
end
