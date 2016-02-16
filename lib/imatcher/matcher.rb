module Imatcher
  class Matcher
    require 'imatcher/image'
    require 'imatcher/result'
    require 'imatcher/modes'

    MODES = {
      rgb: 'RGB',
      delta: 'Delta',
      grayscale: 'Grayscale'
    }

    attr_reader :threshold, :mode

    def initialize(options = {})
      @threshold = options[:threshold] || 0.0
      @mode = Modes.const_get(MODES[options.fetch(:mode, :rgb)])
    end

    def compare(path_1, path_2)
      a, b = Image.from_file(path_1), Image.from_file(path_2)
      fail SizesMismatchError, "\nSize mismatch: first image size: " \
                                     "#{ a.width }x#{ a.height }, " \
                                     "second image size: " \
                                     "#{ b.width }x#{ b.height }" unless a.sizes_match?(b)

      mode.new(threshold: threshold).compare(a, b)
    end
  end
end
