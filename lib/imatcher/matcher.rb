# frozen_string_literal: true

module Imatcher
  # Matcher contains information about compare mode
  class Matcher
    require "imatcher/image"
    require "imatcher/result"
    require "imatcher/modes"

    MODES = {
      rgb: "RGB",
      delta: "Delta",
      grayscale: "Grayscale"
    }.freeze

    attr_reader :mode

    def initialize(**options)
      mode_type = options.delete(:mode) || :rgb
      fail ArgumentError, "Undefined mode: #{mode_type}" unless MODES.key?(mode_type)
      @mode = Modes.const_get(MODES[mode_type]).new(**options)
    end

    def compare(a, b)
      a = Image.from_file(a) unless a.is_a?(Image)
      b = Image.from_file(b) unless b.is_a?(Image)

      unless a.sizes_match?(b)
        fail SizesMismatchError,
          "Size mismatch: first image size: " \
          "#{a.width}x#{a.height}, " \
          "second image size: " \
          "#{b.width}x#{b.height}"
      end

      image_area = Rectangle.new(0, 0, a.width - 1, a.height - 1)

      unless mode.exclude_rect.nil?
        unless image_area.contains?(mode.exclude_rect)
          fail ArgumentError,
            "Bounds must be in image"
        end
      end

      unless mode.include_rect.nil?
        unless image_area.contains?(mode.include_rect)
          fail ArgumentError,
            "Bounds must be in image"
        end
        unless mode.exclude_rect.nil?
          unless mode.include_rect.contains?(mode.exclude_rect)
            fail ArgumentError,
              "Included area must contain excluded"
          end
        end
      end

      mode.compare(a, b)
    end
  end
end
