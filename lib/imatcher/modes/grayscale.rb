module Imatcher
  module Modes
    require 'imatcher/modes/base'

    class Grayscale < Base
      private

      def pixels_equal?(a, b)
        alpha = color_similar?(a(a), a(b))
        brightness = color_similar?(brightness(a), brightness(b))
        brightness && alpha
      end

      def update_result(a, b, x, y)
        @result.diff << [a, b, x, y]
      end

      def background(bg)
        bg.to_grayscale
      end

      def pixels_diff(d, _, _, x, y)
        d[x, y] = rgb(255, 0, 0)
      end

      def create_diff_image(bg, diff_image)
        diff_image
      end

      def score
        @result.diff.length * 1.0 / @result.image.pixels.length
      end

      def color_similar?(a, b)
        tolerance = 16
        d = (a - b).abs
        d < tolerance
      end
    end
  end
end
