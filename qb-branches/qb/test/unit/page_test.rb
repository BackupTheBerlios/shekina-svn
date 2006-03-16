require File.dirname(__FILE__) + '/../test_helper'

class PageTest < Test::Unit::TestCase
  fixtures :pages, :revisions 

  def test_new_create_destroy
    assert_equal pages(:home_page), p=Page.find(1)
    assert p.destroy 
    for p in Page.find :all
      p.destroy
    end
    
    assert p.destroy
    assert_equal [], Page.find(:all)
  end
  
  def test_find_backlinks
    assert cats=pages(:pretty_cats)
    assert_equal 2, cats.backlinks 
    assert cool=pages(:coolness)
    assert_equal 0, cool.backlinks
  
  end
  def test_add_backlinks
    assert cats=pages(:pretty_cats)
    assert page=Page.new
    assert r=Revision.new(
      :author=>Author.find_or_create('nome','ip'),
      :body => "[[Pretty cats]] goo bar baz")     
    page.current_revision=r
    assert p.save
    assert_equal 3,cats.backlinks.size  
  end
  def test_remove_backlinks
    assert cats=pages(:pretty_cats)
    assert home=pages(:home_page)
    assert r=Revision.new( 
        :author=>Author.find_or_create('nome','ip'),
        :body=>"no pretty cats")
    home.current_revision=r
    assert home.save
    assert_equal 1, cats.backlinks.size
  end
end
