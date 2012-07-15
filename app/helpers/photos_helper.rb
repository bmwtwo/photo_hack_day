module PhotosHelper
	#actually I don't need this method...
	def pretty_dump obj
		pretty = ""
		if obj.is_a Array
			pretty.concat "<ul>"
			obj.each_index do |i|
				pretty.concat "<li>[#{i}] #{pretty_dump obj[i]}<\li>"
			end
			pretty.concat "</ul>"
		elsif obj.is_a Hash
			pretty.concat "<ul>"
			obj.each do |k, v|
				pretty.concat "<li>#{k} => #{pretty_dump obj[i]}<\li>"
			end
			pretty.concat "</ul>"
		else
			pretty.concat obj
		end
		pretty
	end
end
