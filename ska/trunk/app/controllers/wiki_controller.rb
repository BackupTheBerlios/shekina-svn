class WikiController < ApplicationController
  
  layout 'application', :except=>['save_page_with_ajax','edit_page_with_ajax']
  
  def view
   @page= Page.find(@params['id'] || 'home')
  rescue PageNotFound
   error
  end

  def edit
      
  end
  
  def error
   # necessario per la presenza di @page in application.rhtml, fixare
   @page=Page.new 'pagina non esistente', 'minchione'
   render :action => "error", :status => "404 Page Not Found"
  end 
  
  def edit_page_with_ajax
   @page=Page.find @params['id']
   render :partial=> 'form'
  rescue PageNotFound
   error  
  end
  
  def save_page_with_ajax
   @page=Page.find @params["id"]
   @page.text= @params['page']["text"]
   @page.save
   render :partial=>'page'
  rescue PageNotFound
   error   
  end 
  
  alias index view #fix 
  def tag
  end
end
