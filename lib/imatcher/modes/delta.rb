module Imatcher
  module Modes
    require 'imatcher/modes/base'

    class Delta < Base
      def pixels_equal?(a, b)
        a == b
      end

      def update_result(a, b, x, y)
        d = euclid(a, b)/(MAX * Math.sqrt(3))
        @result.diff << [a, b, x, y, d]
        @result.score += d
      end

      def score
        @result.score / @expected.pixels.length
      end

      def self.save_diff(expected, diff, path)
        diff_image = Image.new(expected.width, expected.height, WHITE).with_alpha(0)
        diff_image.render_bounds(diff)
        diff.each do |pixels_pair|
          pixels_diff(diff_image, *pixels_pair)
        end
        expected.to_grayscale.compose!(diff_image, 0, 0).save path
      end

      def self.pixels_diff(d, _, _, x, y, a)
        d[x, y] = d.rgba(MAX, 0, 0, (a * MAX).round)
      end

      private

      def euclid(a, b)
        Math.sqrt(
          (r(a) - r(b)) ** 2 +
          (g(a) - g(b)) ** 2 +
          (b(a) - b(b)) ** 2
        )
      end
    end
  end
end
