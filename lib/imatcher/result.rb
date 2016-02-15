module Imatcher
  class Result
    attr_accessor :score, :image
    attr_reader :diff, :mode, :threshold

    def initialize(mode, threshold)
      @score = 0.0
      @diff = []
      @threshold = threshold
      @mode = mode
    end

    def difference_image
      @diff_image ||= mode.diff(image, diff)
    end

    def match?
      score < threshold
    end
  end
end
