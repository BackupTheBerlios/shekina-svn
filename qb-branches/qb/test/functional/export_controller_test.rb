require File.dirname(__FILE__) + '/../test_helper'
require 'export_controller'

# Re-raise errors caught by the controller.
class ExportController; def rescue_action(e) raise e end; end

class ExportControllerTest < Test::Unit::TestCase
  fixtures :pages, :revisions, :authors
  def setup
    @controller = ExportController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_dumpall
    get :dumpall
    assert_template nil
    assert_response :success
    d=YAML.load(@response.body)
    assert_equal "text/yaml",@response.headers['Content-Type']
    assert_equal Hash, d.class
    assert d['pages'] and d['revisions'] and d['authors']
    assert_equal 3, d['pages'].size
    assert_equal d['pages'].size, d['revisions'].size
    assert_equal 1, d['authors'].size
  end
end
