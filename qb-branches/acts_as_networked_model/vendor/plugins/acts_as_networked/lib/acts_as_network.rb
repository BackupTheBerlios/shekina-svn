# This module adds the networking behaviour to an ActiveRecord model.
# The networking logic will use a support table to create n:m associations
# between objects.
#
# Example:
#
# class User < ActiveRecord::Base
#   acts_as_network :join_table => friends,
#      :source_key => :id_user,
#      :destination_key => :id_friend
# end
#
# first = users(:first)
# second = users(:second)
#
### Add a new connection
#
# first.connections << second
#
### Associate a role to a connection if you
### have the 'role' column in the join table
#
# first.connections.push_with_attributes(second, :role => 2)
# role = first.connections.find(second.id).role
#
### check for inclusion
# 
# first.connections.include?(second)
#

require 'active_record'

module Social #:nodoc
  module Acts #:nodoc:
    module Network #:nodoc:
      
      def self.included(mod)
        mod.extend(ClassMethods)
      end
      
      module ClassMethods
        def acts_as_network(options = {})
          configuration = { 
            :class_name => name,
          }
          
          configuration.update(options) if options.is_a?(Hash)

          configuration[:join_table] ||= table_name + '_connections'
          configuration[:source_key] ||= Inflector.underscore(Inflector.demodulize(name)) + "_id"
          configuration[:destination_key] ||= 'connected_' + Inflector.underscore(Inflector.demodulize(name)) + "_id"
          
          @@select_for_find_friends_of_me = 
            'SELECT u.* FROM ' + table_name + ' u WHERE u.id IN (SELECT ' + 
          configuration[:source_key].to_s + 
            ' FROM ' + 
          configuration[:join_table].to_s + 
            ' WHERE ' + 
          configuration[:destination_key].to_s + 
            ' = ? )'
          
          has_and_belongs_to_many :connections,
          :class_name => name,
          :join_table => configuration[:join_table].to_s,
          :foreign_key => configuration[:source_key].to_s,
          :association_foreign_key => configuration[:destination_key].to_s do
          
            def all_in
              find_by_sql([ @@select_for_find_friends_of_me, @owner.id ])
            end
            
            def all_out
              find(:all)
            end
            
            def include?(object)
              find(object.id).nil? ? false : true
            end
            
          end
          
        end  
        
      end
      
    end
    
  end
  
end

# reopen ActiveRecord and include all the above to make
# them available to all our models if they want it

ActiveRecord::Base.class_eval do
  include Social::Acts::Network
end