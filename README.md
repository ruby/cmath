# CMath

Trigonometric and transcendental functions for complex numbers.

CMath is a library that provides trigonometric and transcendental functions for complex numbers. The functions in this module accept integers, floating-point numbers or complex numbers as arguments.

Note that the selection of functions is similar, but not identical, to that in module math. The reason for having two modules is that some users aren't interested in complex numbers, and perhaps don't even know what they are. They would rather have Math.sqrt(-1) raise an exception than return a complex number.

For more information you can see Complex class.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cmath'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cmath

## Usage

To start using this library, simply require cmath library:

```
require "cmath"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ruby/cmath.


## License

The gem is available as open source under the terms of the [2-Clause BSD License](https://opensource.org/licenses/BSD-2-Clause).
