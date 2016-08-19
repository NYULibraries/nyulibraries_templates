$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nyulibraries_templates/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nyulibraries_templates"
  s.version     = NyulibrariesTemplates::VERSION
  s.authors     = ["Eric Griffis"]
  s.email       = ["eric.griffis@nyu.edu"]
  s.homepage    = "http://www.github.com/NYULibraries/nyulibraries_templates"
  s.summary     = "NYULibraries view templates and helpers"
  s.description = "NYULibraries HTML templates and Rails helpers for views"
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/**/*", "README.md"]
  s.test_files = Dir["spec/**/**/**/**/*"]

  s.add_dependency "rails", "~> 4.1"
  s.add_dependency "nyulibraries_institutions", "~> 0.0.2"

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency "test-unit"
  s.add_development_dependency 'sqlite3'
end
