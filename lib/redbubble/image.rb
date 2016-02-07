require 'uri'
module Redbubble
	class Image
		attr_accessor :size, :url

		def initialize(params={})
			@size = params[:size]
			@url = params[:url]
		end

		# An image needs to have a size (small, medium, large) and
		# a valid URL. The URI module provides a useful regexp for ensuring valid URLs
		# by returning nil if no match is found
		def valid?
			return false if ((@url =~ /\A#{URI::regexp(['http', 'https'])}\z/) == nil)
			["small", "medium", "large"].include?(@size) ? true : false
		end

		def empty?
			@size.length == 0 || @url.length == 0
		end

	end
end
