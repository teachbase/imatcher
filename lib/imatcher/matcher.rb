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

      mode.compare(a, b)
    end
  end
end
