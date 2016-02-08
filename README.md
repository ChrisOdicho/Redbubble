# Redbubble

A simple XML to HTML parser for the Redbubble code test.

## Development Env

The application was developed in Ruby 2.2.3 on OSX 10.10.5

## Installation

Clone the repo

    $ git clone https://github.com/ChrisOdicho/redbubble.git

## Usage

Navigate to the redbubble folder and run

		$ bin/redbubble parse -i <input file> -o <output directory>

Input files can be from a directory or a single XML file. If there are multiple XML files, the parser will create subdirectories within the output directory named after each XML file.

For example, running

		$ bin/redbubble parse -i spec/fixtures -o output

Will parse both works.xml and corrupted-works.xml into output/works and output/corrupted-works.

You can also get more information by running

		$ bin/redbubble help parse

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/redbubble. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

