class Article < ActiveRecord::Base
   belongs_to :category
   def self.find_latest
      find_all( nil, #nessuna condizione
               'created_at DESC', #ordinati
               5     # solo 5
               )
   end

end
