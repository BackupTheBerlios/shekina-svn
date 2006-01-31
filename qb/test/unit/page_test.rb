require File.dirname(__FILE__) + '/../test_helper'

class PageTest < Test::Unit::TestCase
  fixtures :pages, :revisions #, :tags

  def test_new_create_destroy
    assert_equal pages(:home_page), p=Page.find(1)
    assert p.destroy 
    for p in Page.find :all
      p.destroy
    end
    
    assert p.destroy
    assert_equal [], Page.find(:all)
  end
  
  def xtest_tags
    assert cats=pages(:pretty_cats)
    assert cats.add_tags( "cool","cats")
    assert_equal ["cats","cool"],cats.tag_names.sort
    assert (cats.tag ["something else"])
    assert_equal 3,cats.tags_count
    assert_equal 3, Tag.find(:all).size
    assert_equal ["cats","cool","something else"],cats.tag_names.sort
    assert cats.save
    uno=Page.find_tagged_with(:all=>"cool")
    assert_equal 1,uno.size

    assert coolness=pages(:cool_stuff)
    coolness.tag ["cool"]
    assert cats.save
    assert_equal ["cool"], coolness.tag_names
    due=Page.find_tagged_with(:all=>"cool")
    assert_equal 2 ,due.size
    uno=Page.find_tagged_with(:all=>"cool cats")
    assert_equal 1,uno.size
    zero=Page.find_tagged_with(:all=>["nonesiste"])
    assert_equal 0,zero.size  
  end
end
