class WikiController < ApplicationController
  
  def view
   @page= Page.find(@params['id'] || 'home')
  rescue PageNotFound
   render :action => "error", :status => "404 Page Not Found"
  end

  def edit
      
  end
  
  alias index view #fix 
  def tag
  end
end
