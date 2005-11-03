require File.dirname(__FILE__) + '/../test_helper'
require 'versions_controller'

# Re-raise errors caught by the controller.
class VersionsController; def rescue_action(e) raise e end; end

class VersionsControllerTest < Test::Unit::TestCase
  fixtures :pages, :versions, :authors
  
  def setup
    @controller = VersionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_create_new
    post(
      :create, 
      :page => { :title => "A brave new world" }, 
      :version => { :body => "So wonderful!" },
      :author_name => "David"
    )

    assert_response :redirect
    #assert_not_nil page = books(:stories).pages.detect { |page| page.title == "A brave new world" }
    
    pages=Page.all
    page = pages.detect { |page| page.title == "A brave new world" }

    assert_not_nil page
    assert_equal "So wonderful!", page.versions.first.body
    assert_equal authors(:david), page.versions.first.author
  end
end
