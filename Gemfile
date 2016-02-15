source 'https://rubygems.org'

gemspec

gem 'pry'
gem 'chunky_png'

local_gemfile = 'Gemfile.local'

if File.exist?(local_gemfile)
  eval(File.read(local_gemfile)) # rubocop:disable Lint/Eval
end
