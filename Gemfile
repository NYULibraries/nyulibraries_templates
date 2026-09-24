source "https://rubygems.org"

# Declare your gem's dependencies in nyulibraries_templates.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

group :development, :test do
  # Allows for testing against multiple rails versions
  rails_version = ENV["RAILS_VERSION"] || "default"

  rails =
    case rails_version
    when "master"
      { github: "rails/rails" }
    when "default"
      ">= 4"
    else
      "~> #{rails_version}"
    end
  gem "rails", rails

  gem 'pry'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'coveralls'
  gem 'bigdecimal', '< 2' # Rails 4.2 still calls BigDecimal.new.
  if RUBY_VERSION.start_with?('2.4.')
    gem 'term-ansicolor', '< 1.8' # Keep Coveralls compatible with Ruby 2.4.
    gem 'loofah', '< 2.21' # Newer versions need Nokogiri::HTML4, unavailable on Ruby 2.4.
  end
  gem 'test-unit'
  gem 'rb-readline'
  gem 'climate_control', "~> 0.0.4"
  gem 'rspec-html-matchers'
  gem 'sqlite3', '~> 1.3.6'
end
