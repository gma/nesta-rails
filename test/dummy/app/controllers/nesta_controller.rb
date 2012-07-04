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
