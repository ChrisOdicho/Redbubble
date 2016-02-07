require 'spec_helper'

describe Redbubble::PageConstructor::Nav do
	before :each do
		@nav_make = Redbubble::PageConstructor::Nav.new(:makes => ["NIKON CORPORATION"])
		@nav_model = Redbubble::PageConstructor::Nav.new(:models => ["NIKON D80"])
	end

	describe "#generate" do
		context "with camera make" do
			it "creates navigation relevant to the make" do
				nav = @nav_make.generate
				expect(Nokogiri::HTML(nav).css("a").last.content).to eq("NIKON CORPORATION")
			end
		end
		context "with camera model" do
			it "creates navigation relevant to the model" do
				nav = @nav_model.generate
				expect(Nokogiri::HTML(nav).css("a").last.content).to eq("NIKON D80")
			end
		end
	end

	describe "#nav_tag" do
		it "returns an index link" do
			nav = @nav_model.nav_tag
			expect(Nokogiri::HTML(nav).css("a").last.content).to eq("Index")
		end
	end

	describe "#link_to" do
		it "returns a slugged link to the camera make/model" do
			nav = @nav_model.link_to("NIKON CORPORATION")
			expect(Nokogiri::HTML(nav).css("a").last.content).to eq("NIKON CORPORATION")
		end
	end

end
