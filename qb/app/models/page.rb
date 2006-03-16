class Page < ActiveRecord::Base

  has_many :revisions, :order => "created_at", :dependent => true
  has_one  :current_revision, :class_name => "Revision", :order => "created_at DESC"

  acts_as_network   :join_table=>"linked_pages",
                    :destination_key=>"linked_id"
#  before_save :extract_page_links

  alias backlinks connections

  def find_or_build_revision(number = nil)
    number ? revisions[number.to_i - 1] : revisions.build(:body => body)
  end
  
  for i in %w{body author created_at excerpt}
    eval %{
      def #{i}
        current_revision ? current_revision.#{i} : "Prima revisione: inserisci il tuo testo"
      end
    }
  end

  def to_param
    title
  end

  class << self
    
    def find_or_create(attributes)
      find_by_title(attributes[:title]) || create(attributes)
    end
    def find_or_build(title)
      find_by_title(title) || new(:title => title)
    end
    def existing_page_titles
      connection.select_values("SELECT title FROM pages")
    end
    def latest_news(num=5)
      find :all, 
           :order=>"updated_at DESC",
           :limit=> num
           
    end
  end
 private
  def extract_page_links
      return if current_revision.nil?
      current_revision.page_links.each do |t|
        if page=Page.find_by_title(t)
          p "-------"+__FILE__+"---------"
          y page
          begin
            page.connections << self unless page.connections.include?(self)
          rescue Exception=>e
            p ("Expected exception:"+e.inspect)
            next
          end
        end
      end
  end

end
