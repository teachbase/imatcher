# frozen_string_literal: true

begin
  require "pry-byebug"
rescue LoadError
end

require "imatcher"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.example_status_persistence_file_path = "tmp/rspec_examples.txt"
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = :random
  Kernel.srand config.seed
end

def image_path(name)
  "#{File.dirname(__FILE__)}/fixtures/#{name}.png"
end
