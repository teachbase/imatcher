require "chunky_png"

begin
  require "oily_png" unless RUBY_PLATFORM == 'java'
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

module Imatcher
  module ColorMethods # :nodoc:
    include ChunkyPNG::Color

    def brightness(a)
      0.3 * r(a) + 0.59 * g(a) + 0.11 * b(a)
    end

    def red
      rgb(255, 0, 0)
    end

    def green
      rgb(0, 255, 0)
    end

    def blue
      rgb(0, 0, 255)
    end
  end
end
