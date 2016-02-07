require 'spec_helper'

describe Redbubble::Work do
	describe "#new" do
		context "with valid parameters" do
			after(:each) { Redbubble::Work.class_variable_set :@@works, [] }

			it "creates a work with images and a camera" do
				valid_work = Redbubble::Work.new(@valid_params)
				expect(valid_work.valid?).to eq(true)
			end
		end

		context "with invalid parameters" do
			it "creates an invalid work and fails validation" do
			  invalid_work = Redbubble::Work.new(@invalid_params)
				expect(invalid_work.valid?).to eq(false)
			end
		end
	end

	describe ".snapped_by" do
		context "with valid camera make/model" do
			it "returns all relevant images" do
				valid_work = Redbubble::Work.new(@valid_params)
				images = Redbubble::Work.snapped_by("NIKON CORPORATION")
				expect(images.count).to eq (1)
			end
		end
		context "with invalid camera make/model" do
			it "returns no images for nonexistant cameras" do
				valid_work = Redbubble::Work.new(@valid_params)
				images = Redbubble::Work.snapped_by("KODAK")
				expect(images.count).to eq (0) # because digital photos are just a fad..
			end
		end
	end

	describe "#get_image" do
		context	"with valid image" do
			it "returns an instance of Redbubble::Image" do
				valid_work = Redbubble::Work.new(@valid_params)
				image = valid_work.get_image("small")
				expect(image.class).to eq (Redbubble::Image)
				expect(image.size).to eq ("small")
			end
		end
		context "with an invalid image" do
			it "returns nil" do
				invalid_work = Redbubble::Work.new(@invalid_params)
				image = invalid_work.get_image("supersized")
				expect(image).to eq (nil)
			end
		end
	end

end
