require 'spec_helper'

describe Redbubble do

	describe "#generate" do

		context "with valid parameters" do
			it "parses XML and creates HTML documents for each camera make & model" do
				Redbubble::App.new.generate(@input_file, @output_directory)
				expect(Dir.glob("#{@output_directory}/*.html").count).to eq(15)
				# 14 actual HTML files, and 1 subfolder for corrupted works
			end
		end

		context "with missing parameters" do
			it "rejects the input and raises an error" do
				app = Redbubble::App.new
				expect{app.generate}.to raise_error(ArgumentError)
			end
		end

	end
end
