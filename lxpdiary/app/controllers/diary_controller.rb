class DiaryController < ApplicationController

  def index
     @articoli=Article.find_latest
  end

  def view
     @articolo= Article.find(@params['id'])
  end

end
