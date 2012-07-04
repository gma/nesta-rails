require 'test_helper'

class NestaRailsTest < ActiveSupport::IntegrationCase
  test 'can render a page from content folder' do
    visit '/page'
    assert find('h1').has_content?('Page heading')
    assert page.has_content?('Page body')
  end

  # test 'can render the Atom feed' do
  # end

  # test 'can render the XML sitemap' do
  # end
end
