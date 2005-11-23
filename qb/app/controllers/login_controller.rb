class LoginController < ApplicationController

  def index
    flash.keep
    @question, answer = question()
    flash["answer"]= answer
    @author_name = cookies[:author_name] || "AnonimoRubyista"
    if answer_ok?  
      @session["authenticated"]=true
      @session["author_name"] = cookies["author_name"] = {
         :value => @params["name"], :expires =>(Time.now + 1.month) 
      }
      redirect_to :controller     => 'revisions', 
                  :action         => 'new',
                  :page_title     => flash['page_title'],
                  :revision_number => flash["revision_number"]
    end
  end
 private  
  def answer_ok?
    @params["answer"] == flash["answer"] and  @params["name"]
  end

  def question
    ["2+2?","4"]
  end
end
