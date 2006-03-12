class ExportController < ApplicationController
  layout nil
  def dumpall
    headers["Content-Type"] = "text/yaml"
    dump={}
    dump['pages']=Page.find :all
    dump['revisions']=dump['pages'].map {|p| p.current_revision}
    dump['authors']=Author.find :all
    render :text => dump.to_yaml
  end
  def schema
      render :text=>((@request.path)+ home_url())
  end
end
