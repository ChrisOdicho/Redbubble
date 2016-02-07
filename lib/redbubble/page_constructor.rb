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

			total_pages = Dir.glob("#{@output_directory}/*.html").count
			puts "#{total_pages} HTML pages in #{@output_directory}".yellow
			puts "\n"
		end

		def index_page
			title = Utils.title
			nav = Nav.new(:makes => Camera.makes).generate
			thumbs = Thumbs.new(:works => @works.take(10)).generate
			output = Utils.modify_template(title, title, nav, thumbs)	
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

		def generate_html(make=nil, model=nil)
			begin
				output = nil
				if Camera.makes.include?(make) || Camera.models.include?(model)
					works = model.nil? || model.instance_of?(Array) ? Work.snapped_by(make) : Work.snapped_by(model)
					model_name = model.instance_of?(Array) ? nil : model
					title = Utils.title(make, model_name)
					nav = Nav.new(:makes => make, :models => model).generate
					thumbs = Thumbs.new(:works => works).generate
					output = Utils.modify_template(title, title, nav, thumbs)
				else
					raise ArgumentError, "Camera not found! (#{make})"
				end
			rescue ArgumentError => e
				puts "Error: #{e}".red
			else
				puts "Successfully generated #{make}"
				output
			end
		end


	end
end

require_relative 'page_constructor/nav'
require_relative 'page_constructor/thumbs'