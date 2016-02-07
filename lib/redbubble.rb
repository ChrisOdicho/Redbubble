module Redbubble
	class App
	  def generate(input_file, output_directory)
	  	works = Redbubble::Parser.parse_works(input_file)
	  	params = {:works => works, :output_directory => output_directory}
	  	pages = Redbubble::PageConstructor.new(params)
	  	pages.generate

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
