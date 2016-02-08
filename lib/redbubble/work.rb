# A Work consists of three images (small, medium, large), a
# camera make, and a camera model.

module Redbubble
	class Work
		attr_accessor :id, :images, :camera
		@@works = []

		def self.snapped_by(camera)
			works = @@works.map{|w| w if w.camera.make == camera || w.camera.model == camera}.compact
		end

		def initialize(params={})
			@id = params[:id]
			@images = params[:images]
			@camera = params[:camera]
			@@works << self unless @@works.map(&:id).include?(self.id) || !self.valid?
		end

		def get_image(size)
			image = @images.map {|i| i if i.size == size}.compact.first if self.valid?
		end

		# Validation needs to check for duplicates, images, make, and model
		# Images need to be an array of three Redbubble::Image's
		# Make and model just need to be strings with any character
		def valid?
			[@id, @images, @camera].each {|param| 
				return false if Utils.empty?(param)
			}
			return false unless @images.instance_of?(Array) && 
				@images.length == 3 && valid_image_collection?(@images) &&
				@camera.instance_of?(Camera)
			return true
		end

		def empty?
			if @id.length == 0 || @images.length == 0 || @camera.length == 0
				return false
			else
				return true
			end
		end

		private
		# An image collection needs to have 1 of each valid 
		# size (small, medium, large)
		def valid_image_collection?(image_collection)
			valid_sizes = ['small','medium','large']
			image_collection.each do |image|
				return false unless image.instance_of?(Image)
				valid_sizes.include?(image.size) ? valid_sizes -= [image.size] : false
			end
			valid_sizes.length == 0 ? true : false
		end

	end
end
