class NestaGenerator < Rails::Generators::Base
  def create_initializer
    create_file 'config/initializers/nesta.rb', <<-EOF
ENV['NESTA_CONTENT'] = File.join(Rails.root, 'content')
ENV['NESTA_TITLE'] = 'Configure your title'
ENV['NESTA_SUBTITLE'] = 'Configure your subtitle'

# ENV['NESTA_AUTHOR__NAME'] = ''
# ENV['NESTA_AUTHOR__URI'] = ''
# ENV['NESTA_AUTHOR__EMAIL'] = ''
#
# ENV['NESTA_DISQUS_SHORT_NAME'] = ''
# ENV['NESTA_GOOGLE_ANALYTICS_CODE'] = ''

require 'sass/util'

require 'nesta/env'
Nesta::Env.root = Rails.root

require 'nesta/app'

Rails.application.config.middleware.insert_after(
  Rack::Lock,
  Rack::Static, :urls => ['/attachments'], :root => File.expand_path('content'))

Haml::Template.options[:format] = :xhtml
    EOF
  end

  def create_controller
    create_file 'app/controllers/nesta_controller.rb', <<-EOF
class NestaController < ApplicationController
  include NestaHelper

  before_filter :set_common_variables, :only => [:show, :feed, :sitemap]

  def show
    @page = Nesta::Page.find_by_path(request.path)
    if @page.nil?
      raise ActionController::RoutingError.new('Not Found')
    end
    set_from_page(:description, :keywords)
    @title = @page.title
    render :action => @page.template
  end

  def feed
    @articles = Nesta::Page.find_articles.select { |a| a.date }[0..9]
    render :atom, :content_type => :xml, :layout => false
  end

  def sitemap
    @pages = Nesta::Page.find_all
    @last = @pages.map { |page| page.last_modified }.inject do |latest, page|
      (page > latest) ? page : latest
    end
    render :sitemap, :content_type => :xml, :layout => false
  end
end
    EOF
  end

  def create_helper
    create_file 'app/helpers/nesta_helper.rb', <<-EOF
module NestaHelper
  include Nesta::View::Helpers
  include Nesta::Navigation::Renderers

  # Override the equivalent method in Nesta::View::Helpers, which uses
  # Sinatra's `haml` method instead of `render`.
  def article_summaries(articles)
    render 'summaries', :pages => articles
  end

  # When used in Rails, Haml's &= markup won't escape the markup that
  # follows it if the string is already marked as safe. This is because
  # the Rails XSS code gets involved, and overrides the behaviour (i.e.
  # breaks) the behaviour of the API. We make a new (unsafe) string to
  # force it to behave itself.
  def permit_html_escape(string)
    String.new(string)
  end
end
    EOF
  end

  def create_templates
    create_file 'app/views/nesta/page.html.haml', <<-'EOF'
~ @page.to_html(self).html_safe
    EOF

    create_file 'app/views/nesta/atom.haml', <<-'EOF'
!!! XML
%feed(xmlns='http://www.w3.org/2005/Atom')
  %title(type='text')= @title
  %generator(uri='http://nestacms.com') Nesta
  %id= atom_id
  %link(href="#{path_to('/articles.xml')}" rel='self')
  %link(href="#{path_to('/')}" rel='alternate')
  %subtitle(type='text')= @subtitle
  - if @articles[0]
    %updated= @articles[0].date(:xmlschema)
  - if @author
    %author
      - if @author['name']
        %name= @author['name']
      - if @author['uri']
        %uri= @author['uri']
      - if @author['email']
        %email= @author['email']
  - @articles.each do |article|
    %entry
      %title= article.heading
      %link{ :href => path_to(article.path), :type => 'text/html', :rel => 'alternate' }
      %id= atom_id(article)
      %content(type='html')&= permit_html_escape(find_and_preserve(absolute_urls(article.body(self))))
      %published= article.date(:xmlschema)
      %updated= article.date(:xmlschema)
      - article.categories.each do |category|
        %category{ :term => category.permalink }
    EOF

    create_file 'app/views/nesta/sitemap.haml', <<-'EOF'
!!! XML
%urlset(xmlns="http://www.sitemaps.org/schemas/sitemap/0.9")
  %url
    %loc= path_to('/')
    %changefreq daily
    %priority 1.0
    %lastmod= @last.xmlschema
  - @pages.each do |page|
    %url
      %loc= path_to(page.path)
      %lastmod= page.last_modified.xmlschema
    EOF
  end

  def create_routes
    route "mount NestaController.action(:show), :at => '/'"
    route "match 'sitemap.xml' => 'nesta#sitemap'"
    route "match 'articles.xml' => 'nesta#feed'"
  end
end
