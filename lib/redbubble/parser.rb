require 'nokogiri'
require 'colorize'
module Redbubble
	module Parser

		# Parse an XML file (expecting a collection of works)
		# Return an array of all valid works
		def self.parse_works(input_file)
			raise(ArgumentError, "Input file must be an XML document") unless File.extname(input_file) == ".xml"
			begin
			  xml_works = File.open(input_file, "r") { |f| Nokogiri::XML(f) }.xpath("//work")
			rescue Nokogiri::XML::SyntaxError => e
			  puts "Error with input file. caught exception: #{e}"
			end
	  	parsed_works, skipped_works = [], []
	  	xml_works.each do |work|
	  		id = work.xpath("id").text
	  		images = []
	  		images << Image.new(:size => "small", :url => work.xpath('urls/url[@type="small"]').text )
	  		images << Image.new(:size => "medium", :url => work.xpath('urls/url[@type="medium"]').text )
	  		images << Image.new(:size => "large", :url => work.xpath('urls/url[@type="large"]').text )
	  		
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
