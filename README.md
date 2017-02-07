[![Gem Version](https://badge.fury.io/rb/imatcher.svg)](https://rubygems.org/gems/imatcher) [![Build Status](https://travis-ci.org/teachbase/imatcher.svg?branch=master)](https://travis-ci.org/teachbase/imatcher)

# Imatcher

Compare PNG images in pure Ruby (uses [ChunkyPNG](https://github.com/wvanbergen/chunky_png)) using different algorithms.
This is an utility library for image regression testing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'imatcher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install imatcher

Additionally, you may want to install [oily_png](https://github.com/wvanbergen/oily_png) to improve performance when using MRI. Just install it globally or add to your Gemfile.

## Modes

Imatcher supports different ways (_modes_) of comparing images.

Source images used in examples:

<img src="https://raw.githubusercontent.com/teachbase/imatcher/master/spec/fixtures/a.png" width="300" />
<img src="https://raw.githubusercontent.com/teachbase/imatcher/master/spec/fixtures/b.png" width="300" />

### Base (RGB) mode

Compare pixels by values, resulting score is a ratio of unequal pixels.
Resulting diff represents per-channel difference.

<img src="https://raw.githubusercontent.com/teachbase/imatcher/master/spec/fixtures/rgb_diff.png" width="300" />

### Grayscale mode

Compare pixels as grayscale (by brightness and alpha), resulting score is a ratio of unequal pixels (with respect to provided tolerance).

Resulting diff contains grayscale version of the first image with different pixels highlighted in red and red bounding box.

<img src="https://raw.githubusercontent.com/teachbase/imatcher/master/spec/fixtures/grayscale_diff.png" width="300" />

### Delta

Compare pixels using [Delta E](https://en.wikipedia.org/wiki/Color_difference) distance.
Resulting diff contains grayscale version of the first image with different pixels highlighted in red (with respect to diff score).

<img src="https://raw.githubusercontent.com/teachbase/imatcher/master/spec/fixtures/delta_diff.png" width="300" />

## Usage

```ruby
# create new matcher with default threshold equals to 0
# and base (RGB) mode
cmp = Imatcher::Matcher.new
cmp.mode #=> Imatcher::Modes::RGB

# create matcher with specific threshold
cmp = Imatcher::Matcher.new threshold: 0.05
cmp.threshold #=> 0.05

# create zero-tolerance grayscale matcher 
cmp = Imatcher::Matcher.new mode: :grayscale, tolerance: 0
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

## Excluding rectangle

<img src="https://raw.githubusercontent.com/teachbase/imatcher/master/spec/fixtures/a.png" width="300" />
<img src="https://raw.githubusercontent.com/teachbase/imatcher/master/spec/fixtures/a1.png" width="300" />

You can exclude rectangle from comparing by passing `:exclude_rect` to `compare`.
E.g., if `path_1` and `path_2` contain images above
```ruby
Imatcher.compare(path_1, path_2, exclude_rect: [200, 150, 275, 200]).match? # => true
```
`[200, 150, 275, 200]` is array of two vertices of rectangle -- (200, 150) is left-top vertex and (275, 200) is right-bottom.

## Including rectangle

You can set bounds of comparing by passing `:include_rect` to `compare` with array similar to previous example

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/teachbase/imatcher.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

