require 'test/test_helper'
require 'lib/qbcloth'
    Mock_helper = Object.new 
    for i in [:auto_link, :link_to, :page_url, :content_tag]
      eval %{def Mock_helper.#{i}(*args) "#{i}(%s)"%args end}
    end
class TC_QbCloth < Test::Unit::TestCase

  def new_qb(str,ary=[])
    QbCloth.new str, ary, Mock_helper

  end
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
    qb=new_qb t
    html= qb.to_html
    assert_equal "&lt; &gt; &#38;",html[5,15]
    span="<span.*?&%s;.*?</span>"
    for i in %w{gt lt amp}
      assert html[/#{span%i}/], "missing #{i}"
    end
  end
  def test_object_repr_in_pre
    qb=new_qb "<pre> #<Object> </pre>"
    assert_equal "<pre> <span class=\"comment\">#&lt;Object&gt; </span></pre>",
                 qb.to_html
  end

  def test_single_wiki_link
    t= "[[linkname]]"
    qb=new_qb  t,%w{linkname}
    assert_equal  "<p>link_to(linkname)</p>",            
                  qb.to_html, 
                  "a single link on a line is swallowed"
  end

  def test_wiki_link
    t= "Foo [[linkname]] *bar*"
    qb=new_qb  t,%w{linkname}
    assert_equal  "<p>Foo link_to(linkname) <strong>bar</strong></p>",            
                  qb.to_html 
  end
end
