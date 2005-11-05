require File.dirname(__FILE__) + '/../test_helper'
require 'pages_controller'

# Re-raise errors caught by the controller.
class PagesController; def rescue_action(e) raise e end; end

class PagesControllerTest < Test::Unit::TestCase
  fixtures :pages, :versions, :authors

  def setup
    @controller = PagesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_home
    get 'show', :page_title=>'Home Page'
    assert_response :success
    assert_tag :tag=>'head', :child=>{:tag=>"title", :content=>SITE_NAME}
  end

  def test_all_pages
    #FIXME: "all"
    get 'index'
    assert_response :success
    assert_tag :tag=>"title", :content=>"All Pages"
  end
  
  def test_recent
    get 'recent'
    assert_response :success
    assert_tag :tag=>"title", :content=>"Recently Revised"
  end

  def xtest_feed
    get 'feed'
    assert_tag :tag=>"rss", :child=>{:tag=>"channel"}
  end

end
