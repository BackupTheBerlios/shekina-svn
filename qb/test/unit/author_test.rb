require File.dirname(__FILE__) + '/../test_helper'

class AuthorTest < Test::Unit::TestCase
  fixtures :authors

  def setup
    @author = Author.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Author,  @author
  end
end
