require 'nokogiri'
require 'colorize'
module Redbubble
	module Parser

		# Parse an XML file (expecting a collection of works)
		# Return an array of all valid works
		def self.parse_works(input_file)
			begin
				if File.extname(input_file) != ".xml"
					raise(ArgumentError, "Input file must be an XML document")
				else
					xml_works = File.open(input_file, "r") { |f| Nokogiri::XML(f) }.xpath("//work")
				end
		  rescue Nokogiri::XML::SyntaxError => e
		  	puts "Error with input file. caught exception: #{e}"
		  else

		  	parsed_works, skipped_works = [], []
		  	xml_works.each do |work|
		  		id = work.xpath("id").text
		  		images = []
		  		["small","medium", "large"].each do |size|
		  			images << Image.new(:size => size, :url => work.xpath('urls/url[@type="'+size+'"]').text )
		  		end
		  		make = work.xpath("exif/make").text
		  		model = work.xpath("exif/model").text
		  		camera = Camera.new(:make => make, :model => model)
		  		new_work = Work.new(:id => id, :images => images,:camera => camera)
		  		if new_work.valid?
		  			parsed_works << new_work
					else
	  				skipped_works << new_work
	  			end
	  		end
	  		puts "#{parsed_works.count} Works parsed from #{input_file}".green
	  		puts "Skipped #{skipped_works.count} Works (IDs: #{skipped_works.map(&:id)})".red
	  		parsed_works

			end
		end

	end
end
