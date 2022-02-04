# frozen_string_literal: true

require_relative "lib/imatcher/version"

Gem::Specification.new do |spec|
  spec.name = "imatcher"
  spec.version = Imatcher::VERSION
  spec.authors = ["palkan"]
  spec.email = ["dementiev.vm@gmail.com"]
  spec.summary = "Image comparison lib"
  spec.description = "Image comparison lib built on top of ChunkyPNG"
  spec.homepage = "http://github.com/teachbase/imatcher"
  spec.license = "MIT"
  spec.metadata = {
    "bug_tracker_uri" => "http://github.com/palkan/imatcher/issues",
    "changelog_uri" => "https://github.com/palkan/imatcher/blob/master/CHANGELOG.md",
    "documentation_uri" => "http://github.com/palkan/imatcher",
    "homepage_uri" => "http://github.com/palkan/imatcher",
    "source_code_uri" => "http://github.com/palkan/imatcher"
  }

  spec.files = Dir.glob("lib/**/*") + Dir.glob("bin/**/*") + %w[README.md LICENSE.txt CHANGELOG.md]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.6"

  spec.add_dependency "chunky_png"

  spec.add_development_dependency "rake", ">= 13.0"
  spec.add_development_dependency "rspec", ">= 3.9"
end
