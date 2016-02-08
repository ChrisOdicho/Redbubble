module Redbubble::Utils

		# Replace whitespace with hyphens and remove
		# any non-alphanumeric characters from a string
		def self.slug(text)
			text.to_s.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
		end

		def self.empty?(object)
			object.nil? || object.empty?
		end

		def self.title(make=nil, model=nil)
			page_title = "Redbubble Works Browser"
			page_title += " > #{make}" unless empty?(make)
			page_title += " > #{model}" unless empty?(model)
			page_title
		end

		def self.html_template(template_file=nil)
			template_file ||= "#{File.dirname(__FILE__)}/utils/output-template.html"
			File.open(template_file) { |f| Nokogiri::HTML(f) }
		end

		def self.modify_template(title, h1, nav, thumbs)
			modified_template, content = html_template, [title, h1, nav]
			tags_to_replace.each_with_index do |tag, i|
				modified_template.css(tag).last.inner_html = content[i]
			end
			body = modified_template.css('body > text()').last
			body.content = ""
			body.add_next_sibling(thumbs)
			modified_template
		end

		def self.tags_to_replace
			tags = ["title", "h1", "nav"]
		end

		def self.create_file(path, extension)
		  dir = File.dirname(path)

		  unless File.directory?(dir)
		    FileUtils.mkdir_p(dir)
		  end

		  path << ".#{extension}"
		  File.new(path, 'w')
		end
end


# Extend the Array class to allow us to filter elements
# by an element's attribute.
# Returns a unique list of results
class Array
  def uniq_by(&blk)
    transforms = []
    self.select do |el|
      should_keep = !transforms.include?(t=blk[el])
      transforms << t
      should_keep
    end
  end
end

# Extend the String class to allow iteration over one element
class String
	def each
		return self
	end
end