

require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'app/models/tag'


class TagTest < Test::Unit::TestCase

  
  def setup
    $VERBOSE=nil
    @path= 'test-tag-file'
    File.new(@path,'w+').close
    Tag.const_set 'TAG_FILE',File.join(RAILS_ROOT,@path)
  end   
   

  def teardown
    #FileUtils.rm_rf(@path)
  end


  def test_add_find
    p=Tag.add 'giochi','grim fandango'
    tags= Tag.find('giochi')
    assert_kind_of Array, tags
    assert_equal 1, tags.size
    assert tags.member?('grim fandango')
    
    p=Tag.add 'giochi','monkey island'
    tags= Tag.find('giochi')
    assert_equal 2, tags.size
    
    p= Tag.add 'fun', 'grim fandango'
    tags= Tag.find('fun')
    assert_equal 1, tags.size
    assert 'grim fandango', tags[0]
    
  end  
 
end
