source 'https://rubygems.org'

gemspec

gem 'pry-byebug' if RUBY_VERSION >= "2.0.0" && RUBY_PLATFORM != 'java'
local_gemfile = 'Gemfile.local'

if File.exist?(local_gemfile)
  eval(File.read(local_gemfile)) # rubocop:disable Lint/Eval
end
