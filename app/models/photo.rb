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

  def self.get_distinct_focal_lengths
  	self.order.select("DISTINCT(focal_length)").map(&:focal_length).reject{|f| !numeric?(f)}.map{|f| f.to_f}.sort
  end

  def self.get_distinct_isos
  	Photo.order.select("DISTINCT(iso)").map(&:iso).reject{|f| !numeric?(f)}.map{|f| f.to_f}.sort
  end

  def self.get_distinct_shutter_speeds
  	raw_speeds = Photo.select("DISTINCT(shutter_speed)").map(&:shutter_speed).reject{|f| !fraction?(f)}
  	floats = raw_speeds.map do |speed|
  		speed.include?('/') ? speed.split('/')[0].to_f / speed.split('/')[1].to_f : speed.to_f
  	end
  	floats.sort
  end

  def self.get_distinct_apertures
  	raw_apertures = Photo.select("DISTINCT(aperture)").map(&:aperture).map{|f| f_number(f)}.reject{|f| f==false}.map{|f| f.to_f}.uniq.sort
  end
end
