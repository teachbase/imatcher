$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'pry-byebug' if RUBY_VERSION >= "2.0.0" && RUBY_PLATFORM != 'java'

if ENV['COVER']
  require 'simplecov'
  SimpleCov.root File.join(File.dirname(__FILE__), '..')
  SimpleCov.start
end

require 'imatcher'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
end

def image_path(name)
  "#{File.dirname(__FILE__)}/fixtures/#{name}.png"
end
