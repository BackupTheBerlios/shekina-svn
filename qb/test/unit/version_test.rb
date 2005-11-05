require File.dirname(__FILE__) + '/../test_helper'

class VersionTest < Test::Unit::TestCase
  fixtures :pages, :versions, :authors

  def test_page_links
    assert_equal %w(Meow Kitty James), versions(:pretty_cats_v1).page_links
  end
  
  def test_updating_of_page
    updated_at_before = pages(:pretty_cats).updated_at
    version=pages(:pretty_cats).versions.create(
        :author=>Author.find_or_create('nome','ip'),
        :body => "Lovely voices!"
    )
    assert updated_at_before < pages(:pretty_cats, :refresh).updated_at
  end
  def test_updating_of_page_fail
    updated_at_before = pages(:pretty_cats).updated_at
    pages(:pretty_cats).versions.create(:body => "Lovely voices!")
    assert updated_at_before == pages(:pretty_cats, :refresh).updated_at
  end
end
