# frozen_string_literal: true

source "https://rubygems.org"

gem "pry-byebug", platform: :mri

gem "oily_png"

gemspec

eval_gemfile "gemfiles/rubocop.gemfile"

local_gemfile = "#{File.dirname(__FILE__)}/Gemfile.local"

if File.exist?(local_gemfile)
  eval(File.read(local_gemfile)) # rubocop:disable Security/Eval
end
