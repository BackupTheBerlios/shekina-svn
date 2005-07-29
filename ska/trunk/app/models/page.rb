class Page
  PAGES_DIR= File.join(RAILS_ROOT,'pages')
  PAGES_EXT= '.text'
  def page(name)
    File.join(PAGES_DIR,name+PAGES_EXT)
  end

  def self.find(name)
    new name
  end
  
  def initialize(name)
    @text= File.read page(name)
    @tags= #Tag
  end
end
