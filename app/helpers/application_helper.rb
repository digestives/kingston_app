module ApplicationHelper

	# title helper method which will go into our views/layouts/application.html.erb

	def title
		base = "Kingston Leisure"
		
		if @title.nil?
			base
		else
			"#{base} | #{@title}"
		end
	end
	
	def logo
		image_tag("logo.png", :alt => "Kingston Leisure")
	end

end
