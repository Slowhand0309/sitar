# coding: utf-8
require 'fiddle'

module Sitar
  module Types

    class Pointer

      class << self

        # Cretae double pointer value.
        # e.g. void **double_ptr;
        def pptr
          Fiddle::Pointer.malloc(Fiddle::SIZEOF_VOIDP)
        end

      end
    end

  end
end
