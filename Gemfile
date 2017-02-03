source 'https://rubygems.org'

gem "rake", "~> 10.0"
gem "rspec", "~> 3.0"

if RUBY_PLATFORM =~ /java/
  gem "chunky_png", "~> 1.3.5"
else
  gem "oily_png", "~> 1.2"
end

gem 'pry-byebug' if RUBY_VERSION >= "2.0.0" && RUBY_PLATFORM != 'java'
local_gemfile = 'Gemfile.local'

if File.exist?(local_gemfile)
  eval(File.read(local_gemfile)) # rubocop:disable Lint/Eval
end
