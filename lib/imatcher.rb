require "imatcher/version"

module Imatcher
  require 'imatcher/matcher'

  def self.compare(path_a, path_b, options = {})
    Matcher.new(options).compare(path_a, path_b)
  end
end
