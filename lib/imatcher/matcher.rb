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
      expected, test = Image.from_file(path_1), Image.from_file(path_2)
      fail SizesMismatchError, "\nSize mismatch: expected size: " \
                                     "#{ expected.width }x#{ expected.height }, " \
                                     "test size: " \
                                     "#{ test.width }x#{ test.height }" unless expected.sizes_match?(test)

      result = Result.new(expected, mode, threshold)
      mode.new(expected, test, result).compare
    end
  end
end
