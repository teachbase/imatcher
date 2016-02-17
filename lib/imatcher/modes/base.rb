module Imatcher
  module Modes
    class Base
      include ColorMethods

      attr_reader :result

      def initialize(threshold: 0.0)
        @threshold = threshold
        @result = Result.new(self, threshold)
      end

      def compare(a, b)
        result.image = a

        b.compare_each_pixel(a) do |b_pixel, a_pixel, x, y|
          next if pixels_equal?(b_pixel, a_pixel)
          update_result(b_pixel, a_pixel, x, y)
        end

        result.score = score
        result
      end

      def diff(bg, diff)
        diff_image = background(bg)
        diff_image.render_bounds(*calculate_bounds(diff))
        diff.each do |pixels_pair|
          pixels_diff(diff_image, *pixels_pair)
        end
        create_diff_image(bg, diff_image)
      end

      private

      def calculate_bounds(diff)
        xmin, xmax, ymin, ymax = result.image.width, 0, result.image.height, 0
        diff.each do |pixels_pair|
          xmin = pixels_pair[2] if pixels_pair[2] < xmin
          xmax = pixels_pair[2] if pixels_pair[2] > xmax
          ymin = pixels_pair[3] if pixels_pair[3] < ymin
          ymax = pixels_pair[3] if pixels_pair[3] > ymax
        end

        [xmin - 1, ymin - 1 , xmax + 1, ymax + 1]
      end
    end
  end
end
