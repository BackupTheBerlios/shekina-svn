# -*- indent-tabs-mode: nil -*-

require 'time'


module DB
    class Log

      attr_accessor :author, :state, :lines, :commit_log
      attr_reader :date, :revision

      def initialize(rev)
        @revision = rev
        @author = @state = @lines = @commit_log = @date = nil
      end

      def date=(val)
        if val.kind_of?(Time)
          @date = val
        else
          @date = Time.parse(val)
        end
        @date.localtime
      end
    end
end

