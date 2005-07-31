require 'db/file'

class Page < DB::File
  STORE_DIR= 'pgaestore'
  STORE = DB::File.new File.join(RAILS_ROOT,STORE_DIR)
  
  attr_accessor :key, :revision, :text
  
  class << self
  # no revision, ATM
    def get(name,rev)
      STORE[name,rev]
    end
  
    def set(key,rev,*args)
      STORE[key,rev]=*args
    end
    def find(key, rev=nil)
      new key, get(key,rev)
    end
  end
  
  def initialize(key,text,rev=nil)
    @key,@revision,@text=key, rev, text
  end
  def save
    Page.set @key, @revision, @text
    self
  end
end
