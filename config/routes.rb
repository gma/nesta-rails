Nesta::Engine.routes.draw do
  match 'articles.xml' => 'site#feed'
  match 'sitemap.xml' => 'site#sitemap'
  mount SiteController.action(:show), :at => '/'
end
