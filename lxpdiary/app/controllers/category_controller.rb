class CategoryController < ApplicationController
  def view
     @articoli = Category.find(@params['id']).articles
  end
end
