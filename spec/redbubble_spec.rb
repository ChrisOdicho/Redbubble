require 'spec_helper'

describe Redbubble do

	describe "#generate" do

		context "with valid parameters" do
			it "parses XML and creates HTML documents for each camera make & model" do
				Redbubble::App.new.generate(@input_file, @output_directory)
				expect(Dir.glob("#{@output_directory}/*.html").count).to eq(15)
			end
		end

		context "with an invalid input file" do
			it "rejects the input file and raises an error" do
				expect{ Redbubble::App.new.generate("no_xml_here.html", @output_directory)
					}.to raise_error(ArgumentError)
			end
		end

	end
end
