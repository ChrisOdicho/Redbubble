require 'redbubble'
RSpec.configure do |config|
	config.before :each do
		image_small = Redbubble::Image.new(:size => "small", :url => "http://example.com")
		image_medium = Redbubble::Image.new(:size => "medium", :url => "http://example.com")
		image_large = Redbubble::Image.new(:size => "large", :url => "http://example.com")
		images = [image_small, image_medium, image_large]
		camera = Redbubble::Camera.new(:make => "NIKON CORPORATION", :model => "NIKON D80")
		@valid_params = {:id => "123", :images => images, :camera => camera}
		@invalid_params = {:images => "", :make => nil, :model => ""}
		@input_file = "spec/fixtures/works.xml"
		@invalid_file = "spec/fixtures/corrupted-works.xml"
		@output_directory = "spec/output"
	end
	config.after :each do
		FileUtils.rm_rf Dir.glob("#{@output_directory}")
	end

 	config.before(:all) { silence_output }
	config.after(:all) { enable_output }
end

# Redirects stderr and stdout to /dev/null.
def silence_output
  @orig_stderr = $stderr
  @orig_stdout = $stdout

  # redirect stderr and stdout to /dev/null
  $stderr = File.new('./spec/stdout.txt', 'w')
  $stdout = File.new('./spec/stderr.txt', 'w')
end

# Replace stdout and stderr so anything else is output correctly.
def enable_output
  $stderr = @orig_stderr
  $stdout = @orig_stdout
  @orig_stderr = nil
  @orig_stdout = nil
end