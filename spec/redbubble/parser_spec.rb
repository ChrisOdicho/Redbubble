require 'spec_helper'

describe Redbubble::Parser do

	describe ".parse_works" do

		context "with valid XML" do

			it "instantiates valid works and returns them as an array" do
				valid_works = Redbubble::Parser.parse_works(@input_file)
				expect(valid_works.length).to eq(12)
			end
		end

		context "with invalid filetype" do
			it "rejects the input file" do

				invalid_file = "coding-test/output-template.html"
				expect{ Redbubble::Parser.parse_works(invalid_file) }.to raise_error(ArgumentError)
			end
		end

	end
end
