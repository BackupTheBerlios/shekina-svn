class CategoryController < ApplicationController
  def view
     @cat=Category.find @params['id']
  end
end
