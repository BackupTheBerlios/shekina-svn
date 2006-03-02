require 'html_diff/lib/html_diff'
require 'qbcloth'
module ApplicationHelper

  def menuitem(name, url)
      content_tag "li",
        link_to_unless(@title == name,name, url),
        { :class=>"navitem"}
  end
        
  def search_box_tag
    string="Cerca nel Wiki"
     %{
    <form action="http://www.google.com/search">
      <div>
        <input type="text" name="q" id="query" value="%s" 
           onfocus="this.value == '%s' ? this.value = '' : true"
        />
        <input type="hidden" name="domains" value="ruby-it.org" />
        <input type="hidden" name="sitesearch" value="ruby-it.org" />
      </div>  
    </form>
     }% [string, string]
   end
     def link_to_old_revision(rev)
      nlink_to( "Back in time",
              revision_url(:page_title => rev.page.title,
                           :revision_number => rev.number-1))+
      " "+
      content_tag("small", "(#{rev.older_revisions.size} older revisions)")
  end

  def link_to_new_revision(rev)
      nlink_to( "Forward in time",
              revision_url(:page_title => rev.page.title,
                           :revision_number => rev.number+1))+
      " "+
      content_tag("small", "(#{rev.newer_revisions.size} newer revisions)")
  end

  def nlink_to(name, options = {}, html_options = {}, *parameters_for_method_reference)
    link_to(name, options, html_options.update(:class => "navlink"), *parameters_for_method_reference)
  end

  def page_title
    @home ? SITE_NAME :  SITE_NAME+": #@title"
  end
  def page_header
    if @home 
      content_tag("h1", "Ruby-it")+
      content_tag("h3","La comunità italiana dedicata a ruby")
    else
      content_tag("h3", SITE_NAME, {:class=>"red"})+
      content_tag("h1",@title.to_s)
    end
  end
  def markup(body, existing_page_titles = Page.existing_page_titles)
    QbCloth.new(body, existing_page_titles,self).to_html
  end

  def differences(original, new)
    HTMLDiff.diff(original, new)
  end
  
  def link_to_author(author)
    link_to(author.name, page_url(:page_title => author)) + " (#{author.ip})"
  end
   
  def recently_changed_pages
    Page.find(:all, :order => "updated_at DESC") 
  end
  def wiki_link(page)
    link_to(page, page_url(:page_title =>page), :class => "existingWikiWord")
  end

end
