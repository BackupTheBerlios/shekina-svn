class ApplicationController < ActionController::Base
  before_filter :set_charset


  protected
    #FIXME: useless?
    def default_url_options(options)
      options.reverse_merge!({ :book_url_name => @book ? @book.url_name : nil })
    end
  def set_charset
    @headers["Content-Type"] = "text/html; charset=utf-8" 
  end
end
