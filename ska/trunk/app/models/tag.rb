
class Tag
  TAG_FILE= File.join(RAILS_ROOT,'tagfile')
  class <<self
    def find(tag)
      
      open TAG_FILE do |f|
        line=f.grep(/^#{tag}:(.*)$/) { $1.chomp }
      end
      
    end
    def add tag, tagged
      unless (find(tag).include? tagged)  
        open  TAG_FILE, 'a' do |f|
          f.puts(tag+":"+tagged)
        end
      end
    end
    
    def delete tag, tagged
      #....???
    end  
  end
end  