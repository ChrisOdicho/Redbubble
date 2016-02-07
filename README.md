# Redbubble

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/redbubble`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Clone the repo

    $ git clone https://github.com/ChrisOdicho/redbubble.git

## Usage

Navigate to the redbubble folder and run

		$ bin/redbubble parse -i <input files> -o <output directory>

Input files can be from a directory or a single XML file. If there are multiple XML files, the parser will create subdirectories within the output directory named after each XML file.

You can also get more information by running

		$ bin/redbubble help parse
		
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/redbubble. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

