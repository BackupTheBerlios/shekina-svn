#require 'db-test-util'

#require 'db/mock'

class TestDBMock < Test::Unit::TestCase
  include DBTestUtil

  private
  def version_management_available?
    true
  end

  def merge_available?
    false
  end

  def diff_available?
    false
  end
  
  def make_db
    DB::Mock.new
  end

  def default_revision
    nil
  end
end
