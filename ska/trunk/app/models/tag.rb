
class Tag
  TAG_FILE= File.join(RAILS_ROOT,'tagfile')
  class <<self
    
    def find_pages(tag)
      
      open TAG_FILE do |f|
        f.grep(/^#{tag}:(.*)$/) { $1.chomp }
      end
      
    end
    
    alias find find_pages 
    
    def add tag, tagged
      unless (find(tag).include? tagged)  
        open  TAG_FILE, 'a' do |f|
          f.puts(tag+":"+tagged)
        end
      end
    end
    
    def find_tags(page)
        open  TAG_FILE do |f|
          f.grep(/^(.*):#{page}$/) { $1 }
        end
    end      
    
    def delete tag, tagged
      #....???
    end  
  end
end  