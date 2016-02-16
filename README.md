# Imatcher

TBD

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'imatcher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install imatcher

## Usage

```ruby
# create new matcher with default threshold equals to 0
# and base (RGB) mode
cmp = Imatcher::Matcher.new
cmp.mode #=> Imatcher::Modes::RGB

# create matcher with specific threshold
cmp = Imatcher::Matcher.new threshold: 0.05
cmp.threshold #=> 0.05

# create matcher with specific mode
cmp = Imatcher::Matcher.new mode: :grayscale
cmp.mode #=> Imatcher::Modes::Grayscale

res = cmp.compare(path_1, path_2)
res #=> Imatcher::Result

res.match? #=> true

res.score #=> 0.0

# Return diff image object
res.difference_image #=> Imatcher::Image

res.difference_image.save(new_path)

# without explicit matcher
res = Imatcher.compare(path_1, path_2, options) 

# equals to
res = Imatcher::Matcher.new(options).compare(path_1, path_2)

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/teachbase/imatcher.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

