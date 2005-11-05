class VersionsController < ApplicationController
  cache_sweeper :page_sweeper, :only => [ :create ]

  before_filter :authorize, :only=>[:new]


  def show
    @page    = Page.find_by_title(params[:page_title])
    @version = @page.versions[params[:version_number].to_i - 1]
  end

  def new
    #Book.transaction do
      @page    = Page.find_or_build(params[:page_title])
      @version = @page.find_or_build_version(params[:version_number])
    #end
    
  end

  def create
    #Book.transactiddon do
      @page   = Page.find_or_create(params[:page])
      version = @page.versions.build(params[:version])
      author  = Author.find_or_create(cookies[:author_name], request.remote_ip)
      version.author =  author
      version.save
    #end

#    cookies[:author_name] = { :value => params[:author_name], :expires => 20.years.from_now }

    redirect_to page_url(:page_title => @page)
  end
 private
  def authorize
    if not @session['authenticated']
      flash["page_title"]    = @params[:page_title]
      flash["version_number"]= @params[:version_number]
      redirect_to(:controller =>'login') 
    end
  end
end
