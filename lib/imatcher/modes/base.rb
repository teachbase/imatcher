module Imatcher
  module Modes
    class Base # :nodoc:
      include ColorMethods

      attr_reader :result, :threshold, :bounds

      def initialize(threshold: 0.0)
        @threshold = threshold
        @result = Result.new(self, threshold)
      end

      def compare(a, b)
        result.image = a
        @bounds = [0, 0, result.image.width - 1, result.image.height - 1]

        b.compare_each_pixel(a) do |b_pixel, a_pixel, x, y|
          next if pixels_equal?(b_pixel, a_pixel)
          update_result(b_pixel, a_pixel, x, y)
        end

        result.score = score
        result
      end

      def diff(bg, diff)
        diff_image = background(bg)
        diff.each do |pixels_pair|
          pixels_diff(diff_image, *pixels_pair)
        end
        create_diff_image(bg, diff_image).render_bounds(*bounds)
      end

      def score
        @result.diff.length.to_f / @result.image.pixels.length
      end

      def update_result(*_args, x, y)
        update_bounds(x, y)
      end

      def update_bounds(x, y)
        bounds[0] = [x, bounds[0]].max
        bounds[1] = [y, bounds[1]].max
        bounds[2] = [x, bounds[2]].min
        bounds[3] = [y, bounds[3]].min
      end
    end
  end
end
