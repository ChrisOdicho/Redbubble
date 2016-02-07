require 'spec_helper'

describe Redbubble::Image do

	describe "#new" do

		context "with valid parameters" do
			before :each do
				@valid_params = {:size => "small", :url => "http://example.com"}
			end

			it "creates an image with valid URL and size attributes" do
				valid_image = Redbubble::Image.new(@valid_params)
				expect(valid_image.valid?).to eq(true)
				expect(valid_image.size).to eq(@valid_params[:size])
				expect(valid_image.url).to eq(@valid_params[:url])
			end
		end

		context "with invalid parameters" do
			before :each do
				@invalid_params = {:size => "extra-large", :url => "bad-example.com"}
			end
			it "creates an invalid image and fails validation" do
				invalid_image = Redbubble::Image.new(@invalid_params)
				expect(invalid_image.valid?).to eq(false)
			end
		end

	end
end
