class PagesController < ApplicationController
  def show
    if @page = Page.find_by_title(params[:page_title]) and (@page.current_revision != nil)
      render
    else
      redirect_to(new_url(:page_title => params[:page_title]))
    end
  end
  def feed
    headers["Content-Type"] = "application/rss+xml"
    render :layout => false
  end
  def sitemap   
    @pages=Page.find_all
    render :layout => false
  end

end
