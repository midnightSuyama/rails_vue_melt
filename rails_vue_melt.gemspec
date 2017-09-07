$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_vue_melt/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_vue_melt"
  s.version     = RailsVueMelt::VERSION
  s.authors     = ["midnightSuyama"]
  s.email       = ["midnightSuyama@gmail.com"]
  s.homepage    = "https://github.com/midnightSuyama/rails_vue_melt"
  s.summary     = "Rails view with webpack=vue optimizer"
  s.description = "Rails view with webpack=vue optimizer"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1"
  s.add_dependency "webpacker", "~> 3.0"

  s.add_development_dependency "rspec"
  s.add_development_dependency "generator_spec"
end
