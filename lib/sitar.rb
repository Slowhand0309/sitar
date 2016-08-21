# coding: utf-8
require "sitar/binder"

module Sitar

  # == Description
  #
  # Load shared librarys (.so, .dll).
  #
  # * +library+ is the specfic library path's
  #
  # == Example
  #
  # module M
  #  extend Sitar
  #  load 'path/liba.so', 'path/libb.so'
  # end
  def load(*library)
    Binder::dlload(*library)
  end

  # Implemention method_missing.
  #
  def method_missing(name, *args)
    e = Binder::at(name, *args)
    unless e
      super(name, *args) # No method error.
    else
      e
    end
  end

  # Create C struct.
  #
  def struct(signature)
    Binder::struct(signature)
  end

  # Create C union.
  #
  def union(signature)
    Binder::union(signature)
  end
end
