module Imatcher
  module Modes # :nodoc:
    require 'imatcher/modes/base'

    # Compare pixels by alpha and brightness.
    #
    # Options:
    # - tolerance - defines the maximum allowed difference for alpha/brightness
    # (default value is 16)
    class Grayscale < Base
      DEFAULT_TOLERANCE = 16

      attr_reader :tolerance

      def initialize(options)
        @tolerance = options.delete(:tolerance) || DEFAULT_TOLERANCE
        super(options)
      end

      def pixels_equal?(a, b)
        alpha = color_similar?(a(a), a(b))
        brightness = color_similar?(brightness(a), brightness(b))
        brightness && alpha
      end

      def update_result(a, b, x, y)
        super
        @result.diff << [a, b, x, y]
      end

      def background(bg)
        bg.to_grayscale
      end

      def pixels_diff(d, _a, _b, x, y)
        d[x, y] = rgb(255, 0, 0)
      end

      def create_diff_image(_bg, diff_image)
        diff_image
      end

      def color_similar?(a, b)
        d = (a - b).abs
        d <= tolerance
      end
    end
  end
end
