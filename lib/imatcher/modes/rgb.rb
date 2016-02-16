module Imatcher
  module Modes
    require 'imatcher/modes/base'

    class RGB < Base
      def pixels_equal?(a, b)
        a == b
      end

      def score
        @result.diff.length * 1.0 / @result.image.pixels.length
      end

      def diff(bg, diff)
        diff_image = Image.new(bg.width, bg.height, BLACK)
        diff_image.render_bounds(*calculate_bounds(diff))
        diff.each do |pixels_pair|
          pixels_diff(diff_image, *pixels_pair)
        end
        diff_image
      end

      def pixels_diff(d, a, b, x, y)
        d[x, y] = rgb(
          (r(a) - r(b)).abs,
          (g(a) - g(b)).abs,
          (b(a) - b(b)).abs
          )
      end

      def update_result(a, b, x, y)
        @result.diff << [a, b, x, y]
      end
    end
  end
end
