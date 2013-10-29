nesta-rails
===========

nesta-rails is a Rails plugin that seamlessly integrates [Nesta CMS][]
into your Rails application. Rather than mounting Nesta as a Rack
application alongside your Rails application, it replaces Nesta's
Sinatra actions with a Rails controller that uses Nesta's library code
to render the files in your content/pages directory.

[Nesta CMS]: http://nestacms.com

Installation
------------

Add the `nesta-rails` gem to your Rails project's `Gemfile` and re-run
Bundler, like this:

    $ echo "gem 'nesta-rails'" >> Gemfile
    $ bundle

Now you can generate a controller, a helper, and a default template for
rendering your pages. The generator will automatically add some routes
to `config/routes.rb` for you.

    $ rails generate nesta
          create  config/initializers/nesta.rb
          create  app/controllers/nesta_controller.rb
          create  app/helpers/nesta_helper.rb
          create  app/views/nesta/page.html.haml
          create  app/views/nesta/atom.haml
          create  app/views/nesta/sitemap.haml
           route  mount NestaController.action(:show), :at => '/'
           route  match 'sitemap.xml' => 'nesta#sitemap'
           route  match 'articles.xml' => 'nesta#feed'

Move the new routes to the bottom of `config/routes.rb` to ensure that
Nesta isn't asked to serve pages that should be handled by other
controllers in your application.

That's it - nesta-rails is installed.

It's now up to you to update your templates/CSS accordingly, but Nesta's
content should be rendered within your Rails app's application layout...

If you want to make changes to the generated controllers and helpers, go ahead.
That's why they're generated; you'll probably want to hack on them at some
point.

License
-------

This project is released under the MIT-LICENSE.
