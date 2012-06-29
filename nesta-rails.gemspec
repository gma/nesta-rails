# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nesta-rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Graham Ashton"]
  gem.email         = ["graham@effectif.com"]
  gem.description   = %q{Embeds the Nesta CMS in a Rails app}
  gem.summary       =<<-EOF
This gem embeds the Nesta CMS (a Sinatra app) cleanly in your Rails app.
All the templates and styles in your Rails app are made available to
pages that are managed by Nesta. Nesta is a Sinatra application, and as
such could be mounted at any path in an existing Rack application, but
using nesta-rails is a cleaner approach.
  EOF
  gem.homepage      = "http://nestacms.com"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nesta-rails"
  gem.require_paths = ["lib"]
  gem.version       = Nesta::Rails::VERSION
end
