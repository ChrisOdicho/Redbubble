require 'thor'
module Redbubble::Cli
    class Application < Thor

      description = "Start the Redbubble Works Parser.\n"
      description << "The input can be an XML file or a directory of XML files.\n"
      description << "The output directory will be created if it doesn't exist.\n\n"
      description << "If there are multiple XML files to be parsed, the output directory will create \n".yellow
      description << "subdirectories matching the names of each XML file that is parsed.\n".yellow
      description << "Note - existing output files will automatically be overwritten".upcase.blue
      desc 'parse', description
      method_option :input, :required => true, :aliases => "i", :desc => "Path to input (or directory of) XML file/s "
      method_option :output, :required => true, :aliases => "o", :desc => "Path to output directory for HTML files"
      
      def parse
        begin
          if File.directory?(options[:input])
            app = Redbubble::App.new
            if Dir.glob("#{options[:input]}/*.xml").count == 0
              raise ArgumentError, "Invalid directory. Could not find any XML files."
            else
              Dir.glob("#{options[:input]}/*.xml") do |file|
                output_dir = options[:output] +"/"+ File.basename(file, ".xml")
                app.generate(file, output_dir)
              end
            end
          elsif File.file?(options[:input]) && File.extname(options[:input]) == ".xml"
            app = Redbubble::App.new
            app.generate(options[:input], options[:output])
          else
            raise ArgumentError, "Invalid input file"
          end
        rescue ArgumentError => e
          puts "Error: #{e}".red
        else
          puts "Successfully parsed all XML files.\n".green
        end
      end


    end
  end