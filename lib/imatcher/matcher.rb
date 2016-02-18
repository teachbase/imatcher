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
      raise SizesMismatchError,
            "Size mismatch: first image size: " \
            "#{a.width}x#{a.height}, " \
            "second image size: " \
            "#{b.width}x#{b.height}" unless a.sizes_match?(b)
      unless mode.exclude_area.empty?
        raise ArgumentError,
              "Bounds must be positive" if mode.exclude_area.detect { |x| x < 0 }
        raise ArgumentError,
              "Bounds must be in image" if [mode.exclude_area[0], mode.exclude_area[2]].detect { |x| x >= a.width } ||
                                           [mode.exclude_area[1], mode.exclude_area[3]].detect { |y| y >= a.height }
      end

      unless mode.include_area.empty?
         raise ArgumentError,
              "Bounds must be positive" if mode.include_area.detect { |x| x < 0 }
         raise ArgumentError,
              "Bounds must be in image" if [mode.include_area[0], mode.include_area[2]].detect { |x| x >= a.width } ||
                                           [mode.include_area[1], mode.include_area[3]].detect { |y| y >= a.height }
         unless mode.exclude_area.empty?
          raise ArgumentError,
                "Excluded area must be in included area" if [mode.exclude_area[0], mode.exclude_area[2]].detect { |x| x > [mode.include_area[0], mode.include_area[2]].max } ||
                                                            [mode.exclude_area[1], mode.exclude_area[3]].detect { |y| y > [mode.include_area[1], mode.include_area[3]].max } ||
                                                            [mode.exclude_area[0], mode.exclude_area[2]].detect { |x| x < [mode.include_area[0], mode.include_area[2]].min } ||
                                                            [mode.exclude_area[1], mode.exclude_area[3]].detect { |y| y < [mode.include_area[1], mode.include_area[3]].max }
         end
      end
      mode.compare(a, b)
    end
  end
end
