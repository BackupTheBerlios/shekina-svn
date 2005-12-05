require 'html_diff/lib/html_diff'

module ApplicationHelper
  def search_box_tag
    string="Cerca nel Wiki"
     %{
    <form action="http://www.google.com/search">
      <div>
        <input type="text" name="q" id="query" value="%s" size="24" 
           onclick="this.value == '%s' ? this.value = '' : true"
        />
        <input type="hidden" name="domains" value="www.ruby-it.org" />
        <input type="hidden" name="sitesearch" value="www.ruby-it.org" />
      </div>
    </form>
     }% [string, string]
  end
  def latest_news
    Page.find( :all, :order=>"updated_at DESC", :limit=> 5)
  end
  def nlink_to(name, options = {}, html_options = {}, *parameters_for_method_reference)
    link_to(name, options, html_options.update(:class => "navlink"), *parameters_for_method_reference)
  end

  def page_title
    @home ? SITE_NAME :  SITE_NAME+": #@title"
  end
  def page_heading
    @home ? "Ruby-it" : content_tag("small", SITE_NAME) + tag("br") + @title.to_s
  end
  def markup(body, existing_page_titles = Page.existing_page_titles)
    RedCloth.new(linkize(auto_link(body), existing_page_titles)).to_html
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

  private
    def linkize(body, existing_titles)
      body.gsub(Revision::PAGE_LINK) do
        page = title = $1
        title = $2 unless $2.empty?
        if existing_titles.include?(page)
          link_to(title, page_url(:page_title => page), :class => "existingWikiWord")
        else
          content_tag("span", title + link_to("?", page_url(:page_title => page)), :class => "newWikiWord")
        end
      end
    end
end
