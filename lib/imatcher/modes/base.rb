module Imatcher
  module Modes
    class Base # :nodoc:
      include ColorMethods

      attr_reader :result, :threshold, :bounds, :exclude_area, :include_area

      def initialize(threshold: 0.0, exclude_area: [], include_area: [])
        @include_area = include_area
        @exclude_area = exclude_area
        @threshold = threshold
        @result = Result.new(self, threshold)
      end

      def compare(a, b)
        result.image = a
        @include_area = [0, 0, a.width - 1, a.height - 1] if include_area.empty?
        @bounds = Array.new(include_area)

        b.compare_each_pixel(a) do |b_pixel, a_pixel, x, y|
          next if pixels_equal?(b_pixel, a_pixel)
          next if point_in_rect?(exclude_area, x, y)
          next unless point_in_rect?(include_area, x, y)
          update_result(b_pixel, a_pixel, x, y)
        end

        result.score = score
        result
      end

      def diff(bg, diff)
        diff_image = background(bg).highlight_rectangle(exclude_area, :blue)
        diff.each do |pixels_pair|
          pixels_diff(diff_image, *pixels_pair)
        end
        create_diff_image(bg, diff_image).highlight_rectangle(bounds).
          highlight_rectangle(include_area, :green)
      end

      def score
        result.diff.length.to_f / area
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

      def area
        area = ((include_area[2] - include_area[0]).abs + 1) *
                 ((include_area[3] - include_area[1]).abs + 1)
        return area if exclude_area.empty?
        area - ((exclude_area[2] - exclude_area[0]).abs + 1) *
                 ((exclude_area[3] - exclude_area[1]).abs + 1)
      end

      def point_in_rect?(rect, x, y)
        return false if rect.empty?
        x.between?(rect[0], rect[2]) && y.between?(rect[1], rect[3])
      end
    end
  end
end
