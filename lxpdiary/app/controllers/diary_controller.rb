class DiaryController < ApplicationController

  def index
     @articoli=Article.find_all
  end

  def view
     @articolo= Article.find(@params['id'])
  end
end
