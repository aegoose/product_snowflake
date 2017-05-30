# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "product_snowflake/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "product_snowflake"
  s.version     = ProductSnowflake::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["aegoose"]
  s.email       = ["aegoose@126.com"]
  s.homepage    = "https://github.com/aegoose/product_snowflake"
  s.summary     = "snowflake id for product model."
  s.description = "snowflake id for product model."
  s.license     = "MIT"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 5.0.2"
  s.add_development_dependency "sqlite3"

end
