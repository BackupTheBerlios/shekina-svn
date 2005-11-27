require File.dirname(__FILE__) + '/../test_helper'
require 'login_controller'

# Re-raise errors caught by the controller.
class LoginController; def rescue_action(e) raise e end; end

class LoginControllerTest < Test::Unit::TestCase
  def setup
    @controller = LoginController.new
    # mighty hack due to being unable to assign to flash['answer'] 
    # before get'ing a page
    def @controller.answer_ok?
      params['answer']=='risposta'
    end 
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_login_no_data
    get 'index'
    assert assigns['question']
    #assert assigns['author_name']
    assert_response :success
    assert flash['answer']
  end
  def test_login_with_data
    # flash['answer']='risposta'
    get 'index', :answer=>'risposta',  :name=>'NomeUtente'
    assert session['authenticated']
    assert cookies['author_name']
    assert_response :redirect
  end
end
