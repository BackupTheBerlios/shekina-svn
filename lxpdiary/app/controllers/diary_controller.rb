class DiaryController < ApplicationController

  def index
     @articoli=Article.find_all
  end

  def view
  end
end
