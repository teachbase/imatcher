module Imatcher
  module Modes
    require 'imatcher/modes/base'

    class RGB < Base
      def pixels_equal?(a, b)
        a == b
      end

      def score
        @result.diff.length * 1.0 / @expected.pixels.length
      end

      def self.diff(expected, diff)
        diff_image = Image.new(expected.width, expected.height, BLACK)
        diff_image.render_bounds(diff)
        diff.each do |pixels_pair|
          pixels_diff(diff_image, *pixels_pair)
        end
        diff_image
      end

      def self.pixels_diff(d, a, b, x, y)
        d[x, y] = d.rgb(
          (d.r(a) - d.r(b)).abs,
          (d.g(a) - d.g(b)).abs,
          (d.b(a) - d.b(b)).abs
          )
      end

      def update_result(a, b, x, y)
        @result.diff << [a, b, x, y]
      end
    end
  end
end
