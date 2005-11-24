class RevisionsController < ApplicationController
  #cache_sweeper :page_sweeper, :only => [ :create ]

  before_filter :authorize, :only=>[:new,:create]


  def show
    @page    = Page.find_by_title(params[:page_title])
    @revision = @page.revisions[params[:revision_number].to_i - 1]
  end

  def new
    Page.transaction do
      @page    = Page.find_or_build(params[:page_title])
      @revision = @page.find_or_build_revision(params[:revision_number])
    end
  end

  def create
    Page.transaction do
      @page   = Page.find_or_create(params[:page])
      revision = @page.revisions.build(params[:revision])
      author  = Author.find_or_create(@session["author_name"], request.remote_ip)
      revision.author =  author
      revision.save
    end

    #cookies[:author_name] = { :value => params[:author_name], :expires => 20.years.from_now }

    redirect_to page_url(:page_title => @page)
  end
 private
  def authorize
    if not @session['authenticated']
      flash["page_title"]    = @params[:page_title]
      flash["revision_number"]= @params[:revision_number]
      redirect_to(:controller =>'login') 
    end
  end
end