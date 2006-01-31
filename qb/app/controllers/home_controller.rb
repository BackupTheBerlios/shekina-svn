class HomeController < ApplicationController

 caches_page :index
 cache_sweeper :page_sweeper
  def index
    @home=true
    @tagline="La comunità italiana di ruby: fun oriented programming language"
    @title ="Ruby-it"
    @pages=Page.latest_news(8)
  end
end
