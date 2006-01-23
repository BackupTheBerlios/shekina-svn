require 'test/unit'
require 'lib/qbcloth'
    s=Mock_helper = Object.new 
    for i in [:auto_link, :link_to, :page_url, :content_tag]
      eval %{
        def s.#{i}(*args)
          "#{i}(%s)"%args
        end
      }
    end
class TC_QbCloth < Test::Unit::TestCase
  def test_escaping
    t= <<-Eof
        this < > & has to be escaped
        while this should be highlighted
        <pre>
          <
          >
          &
        </pre>
    Eof
    qb=QbCloth.new t,[],Mock_helper
    html= qb.to_html
    assert_equal "&lt; &gt; &#38;",html[5,15]
    span="<span.*?&%s;.*?</span>"
    for i in %w{gt lt amp}
      assert html[/#{span%i}/], "missing #{i}"
    end
  end
  def test_object_repr_in_pre
    qb=QbCloth.new "<pre> #<Object> </pre>", [], Mock_helper
    assert_equal "<pre> <span class=\"comment\">#&lt;Object&gt; </span></pre>",
                 qb.to_html
  end

end
