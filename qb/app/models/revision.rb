class Revision < ActiveRecord::Base
  PAGE_LINK = /\[\[([^\]|]*)[|]?([^\]]*)\]\]/
  
  belongs_to :page
  belongs_to :author
  after_save  :page_was_updated
  validates_presence_of :author,:body, :page
  validates_associated :author

  def page_links
    @page_links ||= body.scan(PAGE_LINK).flatten.reject { |link| link.empty? }
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
      page.save
    end
end
