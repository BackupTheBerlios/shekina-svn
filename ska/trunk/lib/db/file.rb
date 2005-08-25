# -*- indent-tabs-mode: nil -*-
# rwiki/db/file.rb
#
# Copyright (c) 2000-2003 Masatoshi SEKI
#
# rwiki/db/file is copyrighted free software by Masatoshi SEKI.
# You can redistribute it and/or modify it under the same term as Ruby.

require 'md5'
require 'monitor'
require 'db/base'
WikiNameTooLongError=Class.new(WikiError)

  module DB
    class File < Base
      #include MonitorMixin
      FILE_EXT='.text'
      
      def initialize(path)
        @dir = path.split(::File::Separator)
        super()
      end

      private
      def set(key, value, opt=nil)
        return if value.nil?
        filename = fname(key)
#        synchronize do
          if value.empty?
            ::File.unlink(filename)
          else
            ::File.open(filename, 'w') {|fp| fp.write(value) }
          end
#        end
      rescue Errno::ENAMETOOLONG
        raise WikiNameTooLongError.new("name '#{key}' is too long for #{self.class}")
      #rescue
      #  nil
      end

      def get(key, rev=nil)
        filename = fname(key)

        return nil unless ::File.exist?(filename)
        ::File.open(filename, 'r') {|fp| fp.read }

      rescue
        nil
      end

      public
      def modified(key)
        filename = fname(key)
        return nil unless ::File.exist?(filename)
        stat = ::File.stat(filename)
        return nil if stat.size == 0
        return stat.mtime
      rescue
        nil
      end

      def revision(key)
        make_digest(get(key))
      end

      def each
        Dir[::File.join(@dir + ['*'+FILE_EXT])].collect do |filename|
          yield(unescape(::File.basename(filename, FILE_EXT)))
        end
      end

      private
      def escape(str)
        str.gsub(/([^a-zA-Z0-9_-])/n){ sprintf("%%%02X", $1.unpack("C")[0]) }
      end

      def unescape(str)
        str.tr('+', ' ').gsub(/((?:%[0-9a-fA-F]{2})+)/n) do
          [$1.delete('%')].pack('H*')
        end
      end

      def fname_old(key)
        ::File.join(*(@dir + [escape(key)]))
      end

      def fname(key)
        fname_old(key) + FILE_EXT
      end

      def make_digest(src)
        MD5.new(src).hexdigest
      end
    end
  end

