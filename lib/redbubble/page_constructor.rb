module Redbubble
	class PageConstructor

		attr_accessor :works, :output_directory

		def initialize(params={})
				@works = params[:works]
				@output_directory = params[:output_directory]
		end

		def generate
			FileUtils::mkdir_p @output_directory
			index_page
			make_pages
			model_pages
			total = Dir.glob("#{@output_directory}/*.html").count
			puts "#{total} HTML pages in '#{@output_directory}' directory\n".yellow
		end

		def index_page
			output = generate_html(Camera.makes)
			f = Utils.create_file("#{@output_directory}/index", "html")
			f.write(output.to_html)
			f.close
		end

		def make_pages
			Camera.makes.each do |make|
				models = Camera.models(make)
				output = generate_html(make, models)
				f = Utils.create_file("#{@output_directory}/#{Utils.slug(make)}", "html")
				f.write(output.to_html)
				f.close
			end
		end

		def model_pages
			Camera.makes.each { |make|
				Camera.models(make).each { |camera|
					output = generate_html(make, camera)
					f = Utils.create_file("#{@output_directory}/#{Utils.slug(camera)}", "html")
					f.write(output.to_html)
					f.close
				}
			}
		end

		# A function that accepts make or model as strings or arrays
		# Returns modified HTML for index, make, and model pages
		# 
		def generate_html(make=nil, model=nil)
			begin
				output = nil
				if make == Camera.makes
					title = Utils.title
					nav = Nav.new(:makes => Camera.makes).generate
					thumbs = Thumbs.new(:works => @works.take(10)).generate
				elsif Camera.makes.include?(make) || Camera.models.include?(model)
					works = Work.snapped_by(make)
					works = Work.snapped_by(model) unless model.nil? || model.instance_of?(Array)
					model_name = model.instance_of?(Array) ? nil : model
					title = Utils.title(make, model_name)
					nav = Nav.new(:makes => make, :models => model).generate
					thumbs = Thumbs.new(:works => works).generate
				else
					raise ArgumentError, "Camera not found! (#{make})"
				end
					output = Utils.modify_template(title, title, nav, thumbs)
					puts "Generated #{title}"
			rescue ArgumentError => e
				puts "Error: #{e}".red
			else
				output unless output.nil?
			end
		end


	end
end

require_relative 'page_constructor/nav'
require_relative 'page_constructor/thumbs'