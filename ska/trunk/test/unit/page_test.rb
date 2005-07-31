#require File.dirname(__FILE__) + '/../test_helper'
require 'test/unit'
$LOAD_PATH << 'lib'
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'app/models/page'


class PageTest < Test::Unit::TestCase
  #fixtures :pages
  
  def setup
    $VERBOSE=nil
    @path = File.join("test-page-store")
    FileUtils.mkdir_p(@path)
    Page.const_set 'STORE',DB::File.new(File.join(RAILS_ROOT,@path))
  end   
   

  def teardown
    FileUtils.rm_rf(@path)
  end
  # Replace this with your real tests.
  def test_new
    p=Page.new 'micione','testo'
    assert_equal p.text, 'testo'
    assert_equal p.key, 'micione'
    assert_equal p.revision, nil
  end

  def test_set_get_find
    Page.set 'pippo',nil, 'nuovotesto'
    page_text= Page.get 'pippo',nil
    assert_equal Page.find('pippo').text, page_text
    assert_equal "nuovotesto\n", page_text
    assert_kind_of Page,  Page.find('pippo')
  end  
  
  def test_find_failing
    assert_raises (PageNotFound){Page.find 'nonexistent'}
  end  
  
  def test_slashn
    Page.set 'pippo',nil, 'testo'
    assert_equal Page.find('pippo').text,"testo\n"
    Page.set 'pippo',nil, "testo\n"
    assert_equal Page.find('pippo').text,"testo\n"
  end
  def test_save
    p=Page.new 'miao','testo testo'
    p2 = p.save
    assert_equal p2, p
    p3 = Page.find( 'miao')
    assert_equal p.key, p3.key 
  end  
  
  def test_save_strange_chars
    p=Page.new '\mi/\n//:ao','testo testo'
    p2 = p.save
    assert_equal p2, p
    p3 = Page.find( '\mi/\n//:ao')
    assert_equal p.key, p3.key 
    
  end    
end
