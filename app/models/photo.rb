class Photo < ActiveRecord::Base
	attr_protected
  # attr_accessible :title, :body

  def self.numeric? v
  	!!(v =~ /^[-+]?[0-9]*\.?[0-9]+$/)
  end

  def self.fraction? v
  	!!(v =~ /^[0-9]*\.?[0-9]+((\/[0-9]*\.?)|([0-9]*))[0-9]+$/)
  end

  def self.f_number v
  	r = /^([fF]\/?|)([0-9]*\.?[0-9]+$)/
  	result = r.match(v)
  	if result.nil?
  		false
  	else
  		result.captures[1]
  	end
  end

  def self.create_from_500px_full photo
  	photo.delete(:user)
  	Photo.create photo do |p|
  		p.id = photo[:id]
  	end
  end



  def self.floatify hash, key
  	hash[key] = hash[key].to_f
  	hash
  end

  def self.fractionify hash, key
  	if hash[key].include?('/')
  		hash[key] = hash[key].split('/')[0].to_f / hash[key].split('/')[1].to_f
  	else
  		hash[key] = hash[key].to_f
  	end
  	return hash
  end

  def self.f_numberify hash, key
  	hash[key] = f_number(hash[key])
  	hash
  end

  def self.filter_focal_length photos
  	photos.reject{|p| !numeric?(p.focal_length)}.map do |p|
  		floatify p, :focal_length
  	end
  end

  def self.filter_iso isos
  	isos.reject{|p| !numeric?(p.iso)}.map do |p|
  		floatify p, :iso
  	end
  end

  def self.filter_shutter_speed sss
  	raw_speeds = sss.reject{|p| !fraction?(p.shutter_speed)}
  	floats = raw_speeds.map do |p|
  		fractionify p, :shutter_speed
  	end
  end

  def self.filter_aperture as
  	raw = as.map do |p|
  		f_numberify p, :aperture
  	end
  	raw.reject{|p| p.aperture==false}.map do |p|
  		floatify p, :aperture
  	end
  end

  def self.ten_times_filter arr #removes items from the end of the array until the last one is less than 2 times the 2nd last
  	while arr[-1] > 10*arr[-2]
  		arr.pop
  	end
  	arr
  end



  def self.get_distinct_focal_lengths
  	raw = filter_focal_length (self.order.select("DISTINCT(focal_length)"))
  	ten_times_filter raw.map(&:focal_length).sort
  end

  def self.get_distinct_isos
  	raw = filter_iso (Photo.order.select("DISTINCT(iso)"))
  	ten_times_filter raw.map(&:iso).sort
  end

  def self.get_distinct_shutter_speeds
  	raw = filter_shutter_speed (Photo.select("DISTINCT(shutter_speed)"))
  	ten_times_filter raw.map(&:shutter_speed).sort
  end

  def self.get_distinct_apertures
  	raw = filter_aperture (Photo.select("DISTINCT(aperture)"))
  	ten_times_filter raw.map(&:aperture).uniq.sort
  end
end
