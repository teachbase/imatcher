$:.push File.expand_path("../lib", __FILE__)
require 'imatcher/version'

Gem::Specification.new do |spec|
  spec.name          = "imatcher"
  spec.version       = Imatcher::VERSION
  spec.authors       = ["palkan"]
  spec.email         = ["dementiev.vm@gmail.com"]

  spec.summary       = ""
  spec.description   = ""
  spec.homepage      = "http://github.com/teachbase/imatcher"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ["lib"]

  spec.add_dependency "chunky_png", "~> 2.2.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency "rspec", "~> 3.0"
end
