module Redbubble
	class Camera
		attr_accessor :make, :model
		@@makes, @@models, @@cameras = [], [], []
		
		def initialize(params={})
			@make = params[:make]
			@model = params[:model]
			if self.valid?
				@@cameras << self unless @@cameras.map(&:model).include?(self.model)
			end
		end

		def self.makes
			@@makes = @@cameras.uniq_by {|c| c.make}.map(&:make)
		end

		def self.models(make=nil)
			if Utils.empty?(make)
				@@models = @@cameras.uniq_by {|c| c.model}.map(&:model)
			else
				@@models = @@cameras.find_all { |c| c.make == make}.map(&:model)
			end
		end

		def self.cameras
			@@cameras
		end

		def each
			return self
		end

		def valid?
			if @make.nil? || @make.length == 0 || @model.nil? || @model.length == 0
				return false
			else
				return true
			end
		end
		def empty?
			@make.length == 0 || @model.length == 0
		end
	end
end