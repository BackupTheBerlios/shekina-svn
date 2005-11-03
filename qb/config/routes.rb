ActionController::Routing::Routes.draw do |map|
=begin
  map.connect  '', :controller => "pages", :action => "show", :page_title => "Home Page"




  map.connect  'pages/:page_title', :controller => "pages", :action => "show"
  map.connect  'pages/:page_title/:controller/:action/:id'
=end

  map.rollback 'pages/:page_title/versions/new/:version_number', :controller => "versions", :action => "new", :requirements => { :version_number => /^\d+$/ }
  map.new      'pages/:page_title/versions/new', :controller => "versions", :action => "new"
  map.version  'pages/:page_title/versions/:version_number', :controller => "versions", :action => "show", :requirements => { :version_number => /^\d+$/ }
  map.recent   'recent', :controller => "pages", :action => "recent"
  map.pages    'pages', :controller => "pages", :action => "index"
  map.home     'home', :controller => "home" 
  map.page     'pages/index/:page_title', :controller => "pages", :action => "show"
  map.feed     'feed.rss', :controller => "pages", :action => "feed"
  map.connect  ':controller/:action/:id'
end
