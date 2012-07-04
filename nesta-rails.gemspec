$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nesta-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nesta-rails"
  s.version     = NestaRails::VERSION
  s.authors     = ['Graham Ashton']
  s.email       = ['graham@effectif.com']
  s.homepage    = 'http://nestacms.com'
  s.summary     = 'A Rails plugin for using Nesta CMS in Rails'
  s.description =<<-EOF
nesta-rails is a Rails plugin that seamlessly integrates Nesta CMS into
your Rails application. Rather than mounting Nesta as a Rack application
alongside your Rails application, it replaces Nesta's Sinatra actions
with a Rails controller that uses Nesta's library code to render the
files in your content/pages directory.
  EOF

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "nesta", "~> 0.9.13"
  s.add_dependency "rails", "~> 3.2.6"

  s.add_development_dependency "sqlite3"
end
