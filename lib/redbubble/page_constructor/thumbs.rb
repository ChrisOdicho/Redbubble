module Redbubble
	class PageConstructor::Thumbs

			attr_accessor :works

			def initialize(params={})
				@works = params[:works]
			end

			def generate
				thumbs = thumb_tag
				@works.each do |work| 
					thumbs << "<a href='" + work.get_image("large").url + "'>"
					thumbs << "<img src='" + work.get_image("small").url + "' /></a>&nbsp;"
				end
				thumbs <<	"</section>"
				thumbs = Nokogiri::HTML(thumbs).at('body').inner_html

			end

			def thumb_tag
				thumb_tag = "<section id='thumbnails'>"
			end
	end
end