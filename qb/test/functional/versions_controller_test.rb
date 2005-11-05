require File.dirname(__FILE__) + '/../test_helper'
require 'versions_controller'

# Re-raise errors caught by the controller.
class VersionsController; def rescue_action(e) raise e end; end

class VersionsControllerTest < Test::Unit::TestCase
  fixtures :pages, :versions, :authors
  
  def setup
    @controller = VersionsController.new  
    # FIXME:
    # ack of meaningful assignment to cookies before post
    # means we can't really test stuff :(
    
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_create_existing_author
    cookies[:author_name]='David'
    post(
      :create, 
      :page => { :title => "A brave new world" }, 
      :version => { :body => "So wonderful!" }
    )
    assert_response :redirect
    assert_not_nil  page=Page.find_by_title("A brave new world")
    
    assert_not_nil page
    assert_equal "So wonderful!", page.versions.first.body
    assert_equal authors(:david), page.versions.first.author
  end


  def test_create_new_author
    cookies[:author_name]='roland'
    post(
      :create, 
      :page => { :title => "A brave new world" }, 
      :version => { :body => "So wonderful!" }
    )
    p 'cookies:'+ cookies[:author_name].to_s
    assert_response :redirect
    assert_not_nil  page=Page.find_by_title("A brave new world")
    author= Author.find_by_name 'roland'
    assert_not_nil page
    assert_equal "So wonderful!", page.versions.first.body
    p page.versions.first
    assert_equal author, page.versions.first.author
  end
end
