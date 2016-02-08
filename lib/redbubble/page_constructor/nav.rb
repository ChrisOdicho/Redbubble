module Redbubble
	class PageConstructor::Nav

		attr_accessor :makes, :models

		def initialize(params={})
			@makes = params[:makes]
			@models = params[:models]

		end

		def generate
			nav = nav_tag
			if Utils.empty?(@models)
				@makes.each { |make| nav << link_to(make) }
			elsif @models.instance_of?(Array)
				@models.each { |model| nav << link_to(model) }
			else
				nav << link_to(@makes)
			end
			nav << "</ul>"
			nav = Nokogiri::HTML(nav).at('body').inner_html
		end

		def nav_tag
			nav_tag = "<ul><li><a href='index.html'>Index</a></li>"
		end

		def link_to(camera)
			link_to = "<li><a href='#{Utils.slug(camera)}.html'>#{camera}</a></li>"
		end
	end
end