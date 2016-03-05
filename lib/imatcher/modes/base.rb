module Imatcher
  module Modes
    class Base # :nodoc:
      require 'imatcher/rectangle'
      include ColorMethods

      attr_reader :result, :threshold, :bounds, :exclude_rect, :include_rect

      def initialize(threshold: 0.0, exclude_rect: nil, include_rect: nil)
        @include_rect = Rectangle.new(*include_rect) unless include_rect.nil?
        @exclude_rect = Rectangle.new(*exclude_rect) unless exclude_rect.nil?
        @threshold = threshold
        @result = Result.new(self, threshold)
      end

      def compare(a, b)
        result.image = a
        @include_rect ||= a.bounding_rect
        @bounds = Rectangle.new(*include_rect.bounds)

        b.compare_each_pixel(a, area: include_rect) do |b_pixel, a_pixel, x, y|
          next if pixels_equal?(b_pixel, a_pixel)
          next if !exclude_rect.nil? && exclude_rect.contains_point?(x, y)
          update_result(b_pixel, a_pixel, x, y)
        end

        result.score = score
        result
      end

      def diff(bg, diff)
        diff_image = background(bg).highlight_rectangle(exclude_rect, :blue)
        diff.each do |pixels_pair|
          pixels_diff(diff_image, *pixels_pair)
        end
        create_diff_image(bg, diff_image).
          highlight_rectangle(bounds).
          highlight_rectangle(include_rect, :green)
      end

      def score
        result.diff.length.to_f / area
      end

      def update_result(*_args, x, y)
        update_bounds(x, y)
      end

      def update_bounds(x, y)
        bounds.left = [x, bounds.left].max
        bounds.top = [y, bounds.top].max
        bounds.right = [x, bounds.right].min
        bounds.bot = [y, bounds.bot].min
      end

      def area
        area = include_rect.area
        return area if exclude_rect.nil?
        area - exclude_rect.area
      end
    end
  end
end
