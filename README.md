nesta-rails
===========

nesta-rails is a Rails plugin that seamlessly integrates Nesta CMS into
your Rails application. Rather than mounting Nesta as a Rack application
alongside your Rails application, it replaces Nesta's Sinatra actions
with a Rails controller that uses Nesta's library code to render the
files in your content/pages directory.

Installation
------------

Add `nesta-rails` to your Rails app's Gemfile and re-bundle your app:

    $ echo 'gem "nesta-rails"' >> Gemfile
    $ bundle

That's it.

This project is released under the MIT-LICENSE.
