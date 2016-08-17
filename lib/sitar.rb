# coding: utf-8
require "sitar/binder"

module Sitar

  def load(*library)
    Binder::dlload(*library)
  end

  def method_missing(name, *args)
    Binder::execute(name, *args)
  end
end
