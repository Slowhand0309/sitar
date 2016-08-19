# coding: utf-8
require 'fiddle'
require 'sitar/helper'

module Sitar
  module Types
    class WideChar

      NULL_STRING = "\u0000".freeze

      class << self

        # Check '\u0000' charactor.
        #
        # === Return
        # If return true, value is '\u0000'.
        def null?(value)
          value == NULL_STRING
        end

        # Convert array to unicode string.
        #
        # === Example
        #
        #   from_array([119]) => 'w'
        def from_array(array)
          array.pack('U*')
        end

        # Convert pointer to unicode string.
        def from_ptr(ptr)
          pointer = Fiddle::Pointer.new(ptr)
          size = 4 # Linux and OS X is 4 bytes UTF-32.
          if Helper.platform_windows?
            size = 2 # Windows UTF-16 2-byte wide chars.
          end

          index = 0
          result = ''
          loop do
            val = []
            size.times do |i|
              n = pointer[index + i].to_i
              val << n if n != 0
            end
            break if val.empty?

            index = index + size

            str = from_array(val)
            result = result + str
          end
          result
        end

      end

    end
  end
end
