# coding: utf-8
require 'sitar/helper'

module Sitar
  module Types

    module Aliases

      def self.included(m)
        m.module_eval{
          if Helper.platform_windows?
            # Windows UTF-16 2-byte wide chars.
            typealias "wchar_t", "short"
          else
            # Linux and OS X is 4 bytes UTF-32.
            typealias "wchar_t", "int"
          end
          typealias "bool", "unsigned char"
        }
      end

    end

  end
end
