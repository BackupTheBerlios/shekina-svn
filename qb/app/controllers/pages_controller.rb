class PagesController < ApplicationController
  cache_sweeper :page_sweeper
  caches_page   :index, :recent

  before_filter :find_book
  
  def index
  end
  
  def recent
  end

  def show
    if @page = Page.find_by_title(params[:page_title])
      render
    else
      redirect_to(new_url(:page_title => params[:page_title]))
    end
  end
  def feed
    render :layout => false
  end

end
