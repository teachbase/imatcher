module Imatcher
  # Matcher contains information about compare mode
  class Matcher
    require 'imatcher/image'
    require 'imatcher/result'
    require 'imatcher/modes'

    MODES = {
      rgb: 'RGB',
      delta: 'Delta',
      grayscale: 'Grayscale'
    }.freeze

    attr_reader :threshold, :mode

    def initialize(options = {})
      mode_type = options.delete(:mode) || :rgb
      @mode = Modes.const_get(MODES[mode_type]).new(options)
    end

    def compare(a, b)
      a = Image.from_file(a) unless a.is_a?(Image)
      b = Image.from_file(b) unless b.is_a?(Image)

      fail SizesMismatchError,
           "Size mismatch: first image size: " \
           "#{a.width}x#{a.height}, " \
           "second image size: " \
           "#{b.width}x#{b.height}" unless a.sizes_match?(b)

      image_area = Rectangle.new(0, 0, a.width - 1, a.height - 1)

      unless mode.exclude_rect.nil?
        fail ArgumentError,
             "Bounds must be in image" unless image_area.contains?(mode.exclude_rect)
      end

      unless mode.include_rect.nil?
        fail ArgumentError,
             "Bounds must be in image" unless image_area.contains?(mode.include_rect)
        unless mode.exclude_rect.nil?
          fail ArgumentError,
               "Included area must contain excluded" unless mode.include_rect.contains?(mode.exclude_rect)
        end
      end

      mode.compare(a, b)
    end
  end
end
