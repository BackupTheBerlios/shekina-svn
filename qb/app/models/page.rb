class Page < ActiveRecord::Base

  has_many :revisions, :order => "created_at", :dependent => true
  has_one  :current_revision, :class_name => "Revision", :order => "created_at DESC"
  
  def find_or_build_revision(number = nil)
    number ? revisions[number.to_i - 1] : revisions.build(:body => body)
  end
  
  def body
    current_revision ? current_revision.body : nil
  end
  
  def author
   current_revision ? current_revision.author : nil
  end

  def created_at
    current_revision ? current_revision.created_at : nil
  end

  def to_param
    title
  end

  #FIXME: remove one 
  def self.find_or_create(attributes)
    find_by_title(attributes[:title]) || create(attributes)
  end
  def self.find_or_build(title)
    find_by_title(title) || create(:title => title)
  end
  def self.existing_page_titles
    connection.select_values("SELECT title FROM pages")
  end
end
