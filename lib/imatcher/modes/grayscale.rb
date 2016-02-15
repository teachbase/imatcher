module Imatcher
  module Modes
    require 'imatcher/modes/base'

    class Grayscale < Base
      def pixels_equal?(a, b)
        alpha = color_similar?(a(a), a(b))
        brightness = color_similar?(brightness(a), brightness(b))
        brightness && alpha
      end

      def update_result(a, b, x, y)
        @result.diff << [a, b, x, y]
      end

      def score
        @result.diff.length * 1.0 / @expected.pixels.length
      end

      def self.save_diff(expected, diff, path)
        diff_image = expected.to_grayscale
        diff_image.render_bounds(diff)
        diff.each do |pixels_pair|
          diff_image[pixels_pair[2], pixels_pair[3]] = diff_image.rgb(255, 0, 0)
        end
        diff_image.save path
      end

      def color_similar?(a, b)
        tolerance = 16
        d = (a - b).abs
        d < tolerance
      end
    end
  end
end
