class Revision < ActiveRecord::Base
  PAGE_LINK = /\[\[([^\]|]*)[|]?([^\]]*)\]\]/
  
  belongs_to :page
  belongs_to :author
  after_save  :page_was_updated
  validates_presence_of :author,:body, :page
  validates_associated :author
  before_save :prepare_backlinks

  def page_links
    @page_links ||= body.scan(PAGE_LINK).map{|k,v| k }
  end

  def excerpt(length=300)
    res=""
    in_tag=false
    body.each_line do |line|
     res+=line
     case line
      when /^\s*<pre>/
        in_tag=true
        next
      when /^\s*<\/pre>/
        in_tag=false
     end
     next if in_tag

     break if res.size > length
    end
    res
  end

  def newer_revisions
    @newer_revisions ||= revisions[revision_index + 1..-1]
  end

  def newer_revisions?
    !newer_revisions.empty?
  end

  def older_revisions
    @older_revisions ||= revisions[0...revision_index].reverse
  end
  
  def older_revisions?
    !older_revisions.empty?
  end
  
  def previous_revision
    @previous_revision ||= older_revisions.first
  end

  def revisions
    page.revisions
  end

  def number
    revision_index + 1
  end
  
  protected
    def revision_index
      revisions.index(self)
    end
    
    def page_was_updated
      page_links.each do |t|
        if linked=Page.find_by_title(t)
          p "-------"+__FILE__+"---------"
          y linked
          begin
            linked.connections << self.page #unless linked.connections.include?(self)
          rescue Exception=>e
            p ("Expected exception:"+e.inspect)
            next
          end
        end
      end
      page.save
    end
    def prepare_backlinks
      #backlinks
    end
end
