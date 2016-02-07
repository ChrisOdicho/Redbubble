require 'spec_helper'

describe Redbubble::Utils do
	describe ".slug" do
		it "downcases, hyphenates spaces and removes non-alphanumerics" do
			slug = Redbubble::Utils.slug("NIKON CORPORATION!")
			expect(slug).to eq("nikon-corporation")
		end
	end

	describe ".nil_or_empty" do
		it "returns true if object is nil or empty" do
			object = ""
			expect(Redbubble::Utils.nil_or_empty?(object)).to eq(true)
		end
	end

	describe ".title" do
		it "creates a breadcrumbed title" do
			title = Redbubble::Utils.title("NIKON CORPORATION")
			expect(title).to eq("Redbubble Works Browser > NIKON CORPORATION")
		end
	end

	describe ".html_template" do
		it "generates a HTML document" do
			template = Redbubble::Utils.html_template
			expect(template.class).to eq(Nokogiri::HTML::Document)
		end
	end

	describe ".modify_template" do
		it "modifies a HTML document" do
			template = Redbubble::Utils.modify_template("Title", "H1", "NAV", "THUMBS")
			expect(template.at_css("h1").content).to eq("H1")
		end
	end
	describe ".create_file" do
		it "creates a file if it doesn't exist" do
			file = Redbubble::Utils.create_file("spec/output/file", "txt")
			expect(File).to exist("spec/output/file.txt")
		end
	end

end








