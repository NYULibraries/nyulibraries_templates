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
  s.summary     = "NYULibraries templates"
  s.description = "NYULibraries templates"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.14.2"

  s.add_development_dependency "sqlite3"
end
