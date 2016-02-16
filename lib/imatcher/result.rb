module Imatcher
  class Result
    attr_accessor :diff, :score

    def initialize(image, mode, threshold)
      @image = image
      @score = 0.0
      @diff = []
      @mode = mode
      @threshold = threshold
    end

    def difference_image
      @mode.diff(@image, @diff)
    end

    def match?
      @score < @threshold
    end
  end
end
