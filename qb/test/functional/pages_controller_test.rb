require File.dirname(__FILE__) + '/../test_helper'
require 'pages_controller'
require 'pp'
# Re-raise errors caught by the controller.
class PagesController; def rescue_action(e) raise e end; end

class PagesControllerTest < Test::Unit::TestCase
  fixtures :pages, :revisions, :authors

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

  def test_show_nonexistent
    tit="nonexistingpage"
    get :show, {:page_title=>tit}
    assert_response :redirect
    # it seem rails is broken wrt this or I'm just dumb
    #assert_redirected_to :controller=>'revisions',:action=>'new',:page_title=>tit
  end

  def test_sitemap
    get :sitemap
    assert_template 'pages/sitemap'
    assert_response :success
    assert_tag :tag=>'urlset', :children=>{:count=>3,:only=>{:tag=>'url'} }
    assert_tag :tag=>'url', :child=>{:tag=>'loc'}
    assert_tag :tag=>'url', :child=>{:tag=>'lastmod'}
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

  def test_feed
    get 'feed'
    assert_template 'pages/feed'
    assert_tag :tag=>"rss", :child=>{:tag=>"channel"}
    assert_tag :tag=>"dc:creator"
  end

  def test_show
    get 'show', :page_title=>'Pretty cats'
    assert_template 'pages/show'
    assert_response :success
    assert_tag :tag=>'div',:attributes=>{:id=>'header'} 
  end
end
