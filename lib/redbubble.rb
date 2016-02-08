module Redbubble
	class App

	  def generate(input_file=nil, output_directory=nil)
	  	begin
	  		if Utils.empty?(input_file)
	  			raise ArgumentError, "Input file missing #{input_file}"
  			elsif Utils.empty?(output_directory)
	  			raise ArgumentError, "Output directory missing #{output_directory}"
	  		else
			  	works = Redbubble::Parser.parse_works(input_file)
			  	params = {:works => works, :output_directory => output_directory}
			  	pages = Redbubble::PageConstructor.new(params)
			  	pages.generate
			  	puts "Redbubble Works Parser completed."
			  end
		  rescue ArgumentError => e
		  	puts "App Input Error: #{e}\n"
		  	raise
		  end
	  end

	end
end
require_relative "redbubble/version"
require_relative "redbubble/parser"
require_relative "redbubble/utils"
require_relative "redbubble/work"
require_relative "redbubble/image"
require_relative "redbubble/page_constructor"
require_relative "redbubble/camera"
require_relative "cli/application"
