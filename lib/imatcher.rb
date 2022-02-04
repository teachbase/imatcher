# frozen_string_literal: true

require "imatcher/version"

# Compare PNG images using different algorithms
module Imatcher
  class SizesMismatchError < StandardError
  end

  require "imatcher/matcher"
  require "imatcher/color_methods"

  def self.compare(path_a, path_b, **options)
    Matcher.new(**options).compare(path_a, path_b)
  end
end
