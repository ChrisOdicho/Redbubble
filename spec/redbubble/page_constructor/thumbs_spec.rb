require 'spec_helper'

describe Redbubble::PageConstructor::Thumbs do
	before :each do
		@works = Redbubble::Parser.parse_works(@input_file)
		@thumbs = Redbubble::PageConstructor::Thumbs.new(:works => @works)
	end

	describe "#generate" do
		it "creates thumbnails from a collection of works" do
			thumbs = @thumbs.generate
			section_id = Nokogiri::HTML(thumbs).at_css("section").attributes["id"].value
			expect(section_id).to eq("thumbnails")
		end
	end

	describe "#thumb_tag" do
		it "returns a thumbnail section HTML" do
			thumbs = @thumbs.thumb_tag
			section_id = Nokogiri::HTML(thumbs).at_css("section").attributes["id"].value
			expect(section_id).to eq("thumbnails")
		end
	end


end
