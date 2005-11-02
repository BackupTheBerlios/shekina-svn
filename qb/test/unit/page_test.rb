require File.dirname(__FILE__) + '/../test_helper'

class PageTest < Test::Unit::TestCase
  fixtures :pages, :versions

  def test_true
    assert true
  end
end
