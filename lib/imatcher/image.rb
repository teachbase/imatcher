require 'imatcher/color_methods'

module Imatcher
  class Image < ChunkyPNG::Image
    include ColorMethods

    def each_pixel
      height.times do |y|
        row(y).each_with_index do |pixel, x|
          yield(pixel, x, y)
        end
      end
    end

    def compare_each_pixel(image)
      height.times do |y|
        next if image.row(y) == row(y)
        row(y).each_with_index do |pixel, x|
          yield(pixel, image[x, y], x, y)
        end
      end
    end

    def to_grayscale
      each_pixel do |test_pixel, x, y|
        self[x, y] = grayscale(brightness(test_pixel).round)
      end
      self
    end

    def with_alpha(value)
      each_pixel do |test_pixel, x, y|
        self[x, y] = rgba(r(test_pixel), g(test_pixel), b(test_pixel), value)
      end
      self
    end

    def sizes_match?(image)
      [width, height] == [image.width, image.height]
    end

    def render_bounds(diff)
      left = xmin(diff) - 1
      right = xmax(diff) + 1
      top = ymax(diff) + 1
      bot = ymin(diff) - 1
      rect(left, bot, right, top, rgb(255, 0, 0))
    end

    private

    def xmin(diff)
      min = width + 1
      diff.each do |pixels_pair|
        min = pixels_pair[2] if pixels_pair[2] < min
      end
      min
    end

    def xmax(diff)
      max = -1
      diff.each do |pixels_pair|
        max = pixels_pair[2] if pixels_pair[2] > max
      end
      max
    end

    def ymin(diff)
      min = height + 1
      diff.each do |pixels_pair|
        min = pixels_pair[3] if pixels_pair[3] < min
      end
      min
    end

    def ymax(diff)
      max = -1
      diff.each do |pixels_pair|
        max = pixels_pair[3] if pixels_pair[3] > max
      end
      max
    end
  end
end
