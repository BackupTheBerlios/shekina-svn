class HomeController < ApplicationController

  def index
    @home=true
    @tagline="La comunità italiana di ruby: fun oriented programming language"
    @title ="Ruby-it"
  end
end
