ActionController::Routing::Routes.draw do |map|
=begin
  map.connect  '', :controller => "pages", :action => "show", :page_title => "Home Page"




  map.connect  'pages/:page_title', :controller => "pages", :action => "show"
  map.connect  'pages/:page_title/:controller/:action/:id'
=end

  map.connect  '', :controller => 'home', :action=>  'index'
  map.rollback 'pages/:page_title/revisions/new/:revision_number', :controller => "revisions", :action => "new", :requirements => { :revision_number => /^\d+$/ }
  map.new      'pages/:page_title/revisions/new', :controller => "revisions", :action => "new"
  map.revision  'pages/:page_title/revisions/:revision_number', :controller => "revisions", :action => "show", :requirements => { :revision_number => /^\d+$/ }
  map.recent   'recent', :controller => "pages", :action => "recent"
  map.pages    'pages', :controller => "pages", :action => "index"

  map.home     'home', :controller => "home" 
  map.sitemap  'pages/sitemap', :controller=>'pages', :action=>'sitemap'
  map.page     'pages/:page_title', :controller => "pages", :action => "show"
  map.feed     'feed.rss', :controller => "pages", :action => "feed"
  map.connect  ':controller/:action/:id'
end
