require 'spec_helper'

describe Redbubble::Camera do
	describe "#new" do
		it "creates a camera" do
			params = {:make => "NIKON CORPORATION", :model => "NIKON D80"}
			camera = Redbubble::Camera.new(params)
			expect(camera.class).to eq(Redbubble::Camera)
		end
	end

	describe ".makes" do
		it "returns array of camera makes" do
			makes = Redbubble::Camera.makes
			expect(makes.first).to eq("NIKON CORPORATION")
		end
	end
	describe ".models" do
		it "returns array of camera models" do
			models = Redbubble::Camera.models
			expect(models.first).to eq("NIKON D80")
		end
	end
	describe ".cameras" do
		it "returns array of all valid cameras" do
			cameras = Redbubble::Camera.cameras
			expect(cameras.first.make).to eq("NIKON CORPORATION")
		end
	end
end