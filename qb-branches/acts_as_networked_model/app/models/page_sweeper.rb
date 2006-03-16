class PageSweeper < ActionController::Caching::Sweeper
  observe Page
  def after_create(page)
    expire_globals
    Page.existing_page_titles.each do |title|
      expire_page :controller=>'pages',:action=>'show',:page_title=>title
    end
  end
  def expire_globals
    expire_page :controller=>'home',:action=>'index'
    expire_page :controller=>'pages',:action=>'feed'
    expire_page :controller=>'pages',:action=>'recent'
    expire_page :controller=>'pages',:action=>'sitemap'
  end
  def after_update(page)
    expire_globals
    expire_page :controller=>'pages',:action=>'show',:page_title=>page.title
  end
end
