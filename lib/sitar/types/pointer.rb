# coding: utf-8
require 'fiddle'

module Sitar
  module Types

    class Pointer

      def pptr
        Fiddle::Pointer.malloc(Fiddle::SIZEOF_VOIDP)
      end

    end

  end
end
