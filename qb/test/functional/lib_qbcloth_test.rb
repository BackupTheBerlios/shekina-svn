require 'test/unit'
require 'lib/qbcloth'
class TC_QbCloth < Test::Unit::TestCase
  def test_escaping
    s=mock_helper = Object.new 
      def s.auto_link(a,b)
        "autolink(#{a},#{b})"
      end
      def s.link_to(*args)
        "link_to(#{args})"
      end
      def s.page_url(*args)
        "page_url(#{args})"
      end
      def s.content_tag(*args)
        "content_tag(#{args})"
      end
    t= <<-Eof
        this < > & has to be escaped
        while this should be highlighted
        <pre>
          <
          >
          &
        </pre>
    Eof
    qb=QbCloth.new t,[],mock_helper
    html= qb.to_html
    assert_equal "this &lt; &gt; &#38;",html[0,20]
    span="<span.*?&%s;.*?</span>"
    assert html[/#{span%"gt"}/], "missing >"
    assert html[/#{span%"lt"}/], "missing <"
    assert html[/#{span%"amp"}/], "missing &"
  end
end
