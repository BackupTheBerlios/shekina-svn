# Backwards compatible URLs with Instiki
class AliasController < ApplicationController
  def show
    redirect_to(page_url(
      :book_url_name => params[:book_url_name], 
      :page_title => params[:page_title] == "HomePage" ? "Home Page" : params[:page_title]
    ))
  end

  def feed
    redirect_to(feed_url(:book_url_name => params[:book_url_name]))
  end
end
