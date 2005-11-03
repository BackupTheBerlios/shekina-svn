class Version < ActiveRecord::Base
  PAGE_LINK = /\[\[([^\]|]*)[|]?([^\]]*)\]\]/
  
  belongs_to :page
  belongs_to :author

  after_save  :page_was_updated

  def page_links
    @page_links ||= body.scan(PAGE_LINK).flatten.reject { |link| link.empty? }
  end

  def newer_versions
    @newer_versions ||= versions[version_index + 1..-1]
  end

  def newer_versions?
    !newer_versions.empty?
  end

  def older_versions
    @older_versions ||= versions[0...version_index].reverse
  end
  
  def older_versions?
    !older_versions.empty?
  end
  
  def previous_version
    @previous_version ||= older_versions.first
  end

  def versions
    page.versions
  end

  def number
    version_index + 1
  end

  protected
    def version_index
      versions.index(self)
    end
    
    def page_was_updated
      page.save
    end
end
