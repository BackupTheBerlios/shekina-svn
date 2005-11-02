class Page < ActiveRecord::Base

  has_many :versions, :order => "created_at", :dependent => true
  has_one  :current_version, :class_name => "Version", :order => "created_at DESC"
  
  def find_or_build_version(number = nil)
    number ? versions[number.to_i - 1] : versions.build(:body => body)
  end
  
  def body
    current_version ? current_version.body : nil
  end
  
  def to_param
    title
  end
  def self.all
    self.find :all
  end

  #FIXME: remove one 
  def self.find_or_create(attributes)
    find_by_title(attributes[:title]) || create(attributes)
  end
  def self.find_or_build(title)
    find_by_title(title) || create(:title => title)
  end
  #FIXME: dumb approach, should exist something better
  def self.existing_page_titles
    find(:all ).map {|p| p.title}
  end
end
