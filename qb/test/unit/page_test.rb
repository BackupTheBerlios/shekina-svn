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
  
  def load_and_save_revisions!
    %w{pretty_cats home_page cool_stuff}.map {|p| pages(p).current_revision.save!}
  end
      
  def test_find_backlinks
    load_and_save_revisions!
    assert cats=Page.find_by_title("Pretty cats")
    assert_equal 2, cats.backlinks.size 
    assert cool=pages(:cool_stuff)
    assert_equal 0, cool.backlinks.size
  
  end
  def test_add_backlinks
    load_and_save_revisions!
    assert cats=pages(:pretty_cats)
    assert_equal 2, cats.backlinks.size
    assert page=Page.new(:title=>rand.to_s)
    assert r=Revision.new(
      :author=>Author.find_or_create('nome','ip'),
      :body => "[[Pretty cats]] goo bar baz")     
    page.current_revision=r
    assert page.save!
    assert_equal 3,cats.backlinks.size  
  end
  def test_remove_backlinks
    load_and_save_revisions!
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
