# TinyPngChecker

Tiny png checker works over [tinypng.com](http://www.tinypng.com) compressor, since TinyPng converter is not deterministic and does not provide a way to know if a file was already compressed, this gem provides some tools to workaround those issues

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tiny_png_checker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tiny_png_checker

## Usage

  Three commands are available. All of them accept a --folders param as a comma separated string list being the folder paths to process:
        
    check    Checks recursively into specified folders for PNG files marked by TinyPngProcessor         
    compress Compress recursively PNGs inside specified folders using TinyPNG and mark files with TinyPngProcessor flag         
    help     Display global or [command] help documentation
    
  Example
  
    tiny_png_checker check --files ~/Documents,~/Images     

  There are some global options:
        
    -h, --help 
        Display help documentation
        
    -v, --version 
        Display version information
        
    -t, --trace 
        Display backtrace when an error occurs
        


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tiny_png_checker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TinyPngChecker project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/tiny_png_checker/blob/master/CODE_OF_CONDUCT.md).
