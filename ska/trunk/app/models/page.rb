require 'db/file'
PageNotFound=Class.new(StandardError)
class Page 
  STORE_DIR= 'pagestore'
  STORE = DB::File.new File.join(RAILS_ROOT,STORE_DIR)
  
  attr_accessor :name, :revision, :text
  
  class << self
  # no revision, ATM
    def get(name,rev)
      STORE[name,rev]
    end
  
    def set(name,rev,*args)
      STORE[name,rev]=*args
    end
    def find(name, rev=nil)
      if page= get(name,rev)
        new name, get(name,rev)
      else
        raise PageNotFound
      end  
    end
  end
  
  def initialize(name,text,rev=nil)
    @name,@revision,@text=name, rev, text
  end
  def save
    Page.set @name, @revision, @text
    self
  end
  def delete
    #nothing, atm
  end  
end
