require File.dirname(__FILE__) + '/../test_helper'
require 'home_controller'

# Re-raise errors caught by the controller.
class HomeController; def rescue_action(e) raise e end; end

class HomeControllerTest < Test::Unit::TestCase
  # fixtures needed to hve news in the main page
  
  fixtures :authors, :pages, :versions
  def setup
    @controller = HomeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  #FIXME: should test the presence of some news
  def test_news
    get 'index'
    assert_tag :tag=>'div', :attributes=>{:id=>'newsitem'}
    assert_tag :tag=>'div', :attributes=>{:id=>'newsbar'}
  end
  def test_side
    get 'index'
    assert_tag :tag=>'div', :attributes=>{:id=>'sideitem'}
    assert_tag :tag=>'div', :attributes=>{:id=>'sidebar'}
  end
  def test_little_stuff
    get 'index'
    assert_tag :ancestor=>{:tag=>'div', :attributes=>{:id => 'sidebar' }},
               :tag => 'a', :content=>'Wiki'
 
    assert_tag :ancestor=>{:tag=>'div', :attributes=>{:id => 'sidebar' }},
               :tag => 'a', :content=>'RSS'
    
    assert_tag :ancestor=>{:tag=>'div', :attributes=>{:id => 'sidebar' }},
               :tag => 'form', :attributes=>{:action=>/google/}
  end
end
