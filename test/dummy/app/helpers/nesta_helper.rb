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
