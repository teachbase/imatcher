require "imatcher/version"

module Imatcher
  class SizesMismatchError < StandardError
	end

  require 'imatcher/matcher'
  require 'imatcher/color_methods'

  def self.compare(path_a, path_b, options = {})
    Matcher.new(options).compare(path_a, path_b)
  end
end
