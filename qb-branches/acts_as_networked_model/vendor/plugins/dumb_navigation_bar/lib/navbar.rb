module Dumb #:nodoc:
  module NavigationBar
    # Creates a list item containing either a single <a> tag or a 
    # the content passed as the first argument. 
    # The behaviour is determined by the second argument, which is an optional url,
    # so that 
    #   navitem "<p>foo</p>"
    # generates a list containing a single paragraph, while
    #   navitem "Administration", admin_url
    # will generate a link to +admin_url+ with content +"Administration"+
    # In case the url is present it will be marked as a link only if 
    # the curent request page does not match
    def navitem(name, url=nil,rgx=nil)
      if url
        matcher=rgx || /#{Regexp.quote(@request.path)}$/
        condition= matcher.match(url)
        content=link_to_unless(condition, name, url)
      else
        content=name
      end
        content_tag "li",
          content,
          { :class=>"navitem"}
    end
    
    # Creates a list (<ul>) filling it with list items, each containing a link.
    # Each arguments must be an +Array+ like this:
    #   ["Item content", "optional url", "optional regex"]
    # See +navitem+ documentation for further details. 
    def navbar(*ary)
      content_tag "ul",
        ary.map {|name, url,rgx| 
          #p 'nr: '+rgx.to_s
          navitem(name, url,rgx)
        }.join("\n"),
        {:id=>"navlist"}
    end
  end
end
  