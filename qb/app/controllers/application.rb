class ApplicationController < ActionController::Base
  protected
    def find_book
      #@book = Book.find(1)
    end

    def default_url_options(options)
      options.reverse_merge!({ :book_url_name => @book ? @book.url_name : nil })
    end
end
