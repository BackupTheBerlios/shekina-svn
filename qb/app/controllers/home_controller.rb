class HomeController < ApplicationController

  def index
    @home=true
    @tagline="ruby: fun oriented programming language"
    @title ="Ruby-it"
  end
end
