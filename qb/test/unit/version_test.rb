require File.dirname(__FILE__) + '/../test_helper'

class RevisionTest < Test::Unit::TestCase
  fixtures :pages, :revisions, :authors

  def test_page_links
    assert_equal %w(Meow Kitty James), revisions(:pretty_cats_v1).page_links
  end
  
  def test_updating_of_page
    updated_at_before = pages(:pretty_cats).updated_at
    revision=pages(:pretty_cats).revisions.create(
        :author=>Author.find_or_create('nome','ip'),
        :body => "Lovely voices!"
    )
    assert updated_at_before < pages(:pretty_cats, :refresh).updated_at
  end
  def test_updating_of_page_fail
    updated_at_before = pages(:pretty_cats).updated_at
    pages(:pretty_cats).revisions.create(:body => "Lovely voices!")
    assert updated_at_before == pages(:pretty_cats, :refresh).updated_at
  end
end
