require 'db/file'
PageNotFound=Class.new(StandardError)
class Page 
  STORE_DIR= 'pagestore'
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
      if page= get(key,rev)
        new key, get(key,rev)
      else
        raise PageNotFound
      end  
    end
  end
  
  def initialize(key,text,rev=nil)
    @key,@revision,@text=key, rev, text
  end
  def save
    Page.set @key, @revision, @text
    self
  end
  def delete
    #nothing, atm
  end  
end
