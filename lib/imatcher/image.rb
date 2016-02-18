require 'imatcher/color_methods'

module Imatcher
  # Extend ChunkyPNG::Image with some methods.
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
      each_pixel do |pixel, x, y|
        self[x, y] = grayscale(brightness(pixel).round)
      end
      self
    end

    def with_alpha(value)
      each_pixel do |pixel, x, y|
        self[x, y] = rgba(r(pixel), g(pixel), b(pixel), value)
      end
      self
    end

    def sizes_match?(image)
      [width, height] == [image.width, image.height]
    end

    def render_bounds(left, bot, right, top)
      rect(left, bot, right, top, rgb(255, 0, 0))
    end

    def inspect
      "Image:#{object_id}<#{width}x#{height}>"
    end

    def highlight_rectangle(rect_bounds, color = :red)
      return self if rect_bounds.empty?
      color = case color
              when :red
                rgb(255, 0, 0)
              when :blue
                rgb(0, 0, 255)
              when :green
                rgb(0, 255, 0)
              end
      rect(*rect_bounds, color)
      self
    end
  end
end
