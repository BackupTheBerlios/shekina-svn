require File.dirname(__FILE__) + '/../test_helper'
require 'revisions_controller'

# Re-raise errors caught by the controller.
class RevisionsController; def rescue_action(e) raise e end; end

class RevisionsControllerTest < Test::Unit::TestCase
  fixtures :pages, :revisions, :authors
  
  def setup
    @controller = RevisionsController.new  
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_create_existing_author
    assert_nil Page.find_by_title("A brave new world")
    authorname='David'
    post(
      :create, 
      {
        :page => { :title => "A brave new world" }, 
        :revision => { :body => "So wonderful!" }
      },
      { #session vars
        "authenticated" => true,
        "author_name" =>   authorname
      },
      {# flashvars }
      }    
    )
    assert_equal session['author_name'],authorname
    assert_response :redirect

    page=Page.find_by_title("A brave new world")
    assert_not_nil page, "page nil, it was not saved"
    assert_not_nil  page.current_revision  , "revision nil it was not saved"

    assert_equal "So wonderful!", page.revisions.first.body
    assert_equal authors(:david), page.revisions.first.author
  end

  def test_create_new_author
    assert_nil Page.find_by_title("A brave new world")

    authorname="Some new AuthorName"
    post(
      :create, 
      { #params
        :page => { :title => "A brave new world" }, 
        :revision => { :body => "So wonderful!" }
      },
      { #session vars
        "authenticated" => true,
        "author_name" =>   authorname
      },
      {# flashvars }
      }    
    )
    assert_response :redirect
    assert_equal session['author_name'],authorname
    
    page=Page.find_by_title("A brave new world")
    author= Author.find_by_name  authorname
    
    assert_not_nil page
    assert_not_nil author
    assert_not_nil page.current_revision  
    
    assert_equal "So wonderful!", page.revisions.first.body
    assert_equal author, page.revisions.first.author
  end

  def test_show_old
    page=Page.new :title=>"title"
    for i in 0..3
      a=Author.find :first
      r=Revision.new :body=>i.to_s
      r.author=a
      page.current_revision=r
      assert page.save!
    end
    get :show, {:page_title=>page.title,:revision_number=>1}
    assert_template "revisions/show"
    assert_tag :tag=>'a', :attributes=>{'class'=>'navigation'},:text=>"Forward in time"

#    get :show, {:page_title=>page.title,:revision_number=>2}
#    assert_tag :tag=>'a', :attributes=>{'class'=>'navigation'},:text=>"Back in time"
  end
end
