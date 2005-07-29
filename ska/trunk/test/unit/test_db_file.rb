
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require File.join(File.dirname(__FILE__),'db_test_util')
require File.join(File.dirname(__FILE__),'test_db_mock')

#$LOAD_PATH << File.join(RAILS_ROOT,'lib')
require 'db/file'
require 'db/mock'

class TestDBMock < Test::Unit::TestCase
  include DBTestUtil

  def setup
    super
    setup_basic
  end

  def teardown
    super
    teardown_basic
  end

  private
  def version_management_available?
    false
  end

  def merge_available?
    false
  end

  def make_db
    DB::File.new(@path)
  end

  def default_revision
    MD5.new(nil).hexdigest
  end
  
  def setup_basic
    @path = File.join("test", "test-rd")
    FileUtils.mkdir_p(@path)
  end

  def teardown_basic
    FileUtils.rm_rf(@path)
  end
end
