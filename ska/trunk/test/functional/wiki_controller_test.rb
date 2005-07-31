require File.dirname(__FILE__) + '/../test_helper'
require 'wiki_controller'

# Re-raise errors caught by the controller.
class WikiController; def rescue_action(e) raise e end; end

class WikiControllerTest < Test::Unit::TestCase
  def setup
    @controller = WikiController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @page=Page.new( 'home', 'testo testo').save
  end
  def teardown
    @page.delete
  end  

  # Replace this with your real tests.
  def test_view_exists
    get :view, {'id' => "home"}
    assert_not_nil assigns["page"]
    assert_template "wiki/view" 
    assert_response :success 
    
    assert_tag :tag => "div",
               :attributes => { :id => "navigation" },
               :parent => { :tag => "body"},
               :descendant => { :tag => "a"}
               
    assert_tag :tag => "div",
               :attributes => { :id => "body" },
               :parent => { :tag => "body"}
               
               
    assert_tag :tag => "div",
               :attributes => { :id => "revision" },
               :parent => { :tag => "body"}
               
  end
  def test_view_no_id
    get :view
    assert_not_nil assigns["page"]
    assert_template "wiki/view" 
    assert_response :success 
  end

  def test_view_wrong_id
    #assert_raises(nil){
    get :view,{'id'=>'null'}
    #}
    assert_template "wiki/error"
    assert_response 404
  end
end
