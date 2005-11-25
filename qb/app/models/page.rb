# this saves from rescueing everywhere
class << nil
  def body
    ""
  end
  def created_at
    Time.now
  end
  def author
    Author.find_by_name "Ruby Fan"
  end
end

class Page < ActiveRecord::Base

  has_many :revisions, :order => "created_at", :dependent => true
  has_one  :current_revision, :class_name => "Revision", :order => "created_at DESC"
  
  #validates_presence_of :revisions
  #validates_associated :current_revision

  def find_or_build_revision(number = nil)
    number ? revisions[number.to_i - 1] : revisions.build(:body => body)
  end
  
  def body
    current_revision ? current_revision.body : nil
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
