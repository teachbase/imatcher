# frozen_string_literal: true

module Imatcher
  # Object containing comparison score and diff image
  class Result
    attr_accessor :score, :image
    attr_reader :diff, :mode, :threshold, :lower_threshold

    def initialize(mode, threshold:, lower_threshold:)
      @score = 0.0
      @diff = []
      @threshold = threshold
      @lower_threshold = lower_threshold
      @mode = mode
    end

    def difference_image
      @diff_image ||= mode.diff(image, diff)
    end

    # Returns true iff score less or equals to threshold
    def match?
      score <= threshold && score >= lower_threshold
    end
  end
end
