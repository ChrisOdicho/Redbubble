require 'spec_helper'

describe Redbubble::PageConstructor do
	describe "#generate" do
		context "with valid works" do
			before :each do
				works = Redbubble::Parser.parse_works(@input_file)
				valid_params = {:works => works, :output_directory => @output_directory}
				@valid_page = Redbubble::PageConstructor.new(valid_params)
			end
			it "creates ALL pages" do
				@valid_page.generate
				expect(Dir.glob("#{@output_directory}/*.html").count).to eq(14)
			end
			it "creates MAKE pages" do
				@valid_page.make_pages
				expect(File).to exist("#{@output_directory}/nikon-corporation.html")
			end

			it "creates MODEL pages" do
				@valid_page.model_pages
				expect(File).to exist("#{@output_directory}/nikon-d80.html")
			end

			it "creates INDEX page" do
				@valid_page.index_page
				expect(File).to exist("#{@output_directory}/index.html")
			end
		end

		context "with invalid works" do
			before :each do
				works = Redbubble::Parser.parse_works(@invalid_file)
				@dir = "#{@output_directory}/corrupted-works"
				invalid_params = {:works => works, :output_directory => @dir}
				@invalid_page = Redbubble::PageConstructor.new(invalid_params)
			end
			after :each do
				FileUtils.rm_rf Dir.glob("#{@dir}")
			end
			it "parses potentially valid nodes" do
				@invalid_page.generate
				expect(Dir).to exist(@dir)
			end
		end
	end

	describe "#generate_html" do
		context "with valid parameters" do
			it "returns a modified html template" do
				works = Redbubble::Parser.parse_works(@input_file)
				valid_params = {:works => works, :output_directory => @output_directory}
				valid_page = Redbubble::PageConstructor.new(valid_params)
				output = valid_page.generate_html("NIKON CORPORATION")
				expect(output.at_css('h1').content).to eq ("Redbubble Works Browser > NIKON CORPORATION")
			end
		end
		context "with invalid parameters" do
			it "raises an error" do
				works = Redbubble::Parser.parse_works(@input_file)
				valid_params = {:works => works, :output_directory => @output_directory}
				valid_page = Redbubble::PageConstructor.new(valid_params)
				content = valid_page.generate_html("KODAK")
				expect(content).to eq(nil)
			end
		end
	end

end
