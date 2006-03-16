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
  
end
