require 'chunky_png'

module Imatcher
  module ColorMethods # :nodoc:
    include ChunkyPNG::Color

    def brightness(a)
      0.3 * r(a) + 0.59 * g(a) + 0.11 * b(a)
    end
  end
end
