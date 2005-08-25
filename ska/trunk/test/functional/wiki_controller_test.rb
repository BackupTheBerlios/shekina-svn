require File.dirname(__FILE__) + '/../test_helper'
require 'wiki_controller'
require 'db/mock'
# Re-raise errors caught by the controller.
class WikiController; def rescue_action(e) raise e end; end
$VERBOSE=nil
Page.const_set :STORE, DB::Mock.new

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
               :attributes => { :id => "sidebar" },
               :parent => { :tag => "div", :attributes=>{:id=>"container"} },
               :descendant => { :tag => "a"}
               
    
    assert_tag :tag => "div",
               :attributes => { :id => "main" },
               :parent => { :tag => "div", :attributes=>{:id=>"container"} }
               
               
    assert_tag :tag => "div",
               :attributes => { :id => "revision" },
               :parent => { :tag => "div", :attributes=>{:id=>"container"} }
               
  end
  def test_view_no_id
    get :view
    assert_not_nil assigns["page"]
    assert_template "wiki/view" 
    assert_response :success 
  end
  
  def error_helper
    assert_template "wiki/error"
    assert_response 404
  end
  def test_view_wrong_id
    #assert_raises(nil){
    get :view,{'id'=>'null'}
    error_helper
  end
  
  def test_edit_page_with_ajax
    get :edit_page_with_ajax, {:id=>'home'}
    assert_template "wiki/_form"
    assert_not_nil assigns["page"]
    assert_response :success 
    assert_tag :tag => "div",
               :attributes => { :id => "form-body" }
               
    assert_tag :tag => "form",
               :descendant => { :tag => "textarea"}
    assert_tag :tag => "form",
               :descendant => { :tag => "input",:attributes=>{:type=>"submit"} }
  end
  
  def test_edit_page_with_ajax_error
    
    get :edit_page_with_ajax, {:id=>'test-non-.deve-esistere',:page=>{:text=>'testo'}}
    error_helper


  end

  def test_save_page_with_ajax
    get :save_page_with_ajax, {:id=>'home',:page=>{:text=>'testo'}}
    assert_template "wiki/_page"
  end  
  
  
  def test_save_page_with_ajax_wrong_id
    get :save_page_with_ajax, {:id=>'test-non-.deve-esistere',:page=>{:text=>'testo'}}
    error_helper
  end
  
  
end
