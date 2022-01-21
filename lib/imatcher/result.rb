# frozen_string_literal: true

module Imatcher
  # Object containing comparison score and diff image
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

    # Returns true iff score less or equals to threshold
    def match?
      score <= threshold
    end
  end
end
