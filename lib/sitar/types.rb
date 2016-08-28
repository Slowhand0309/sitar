# coding: utf-8
require 'active_support'

module Sitar
  module Types
    extend ActiveSupport::Autoload

    autoload :Aliases
    autoload :Pointer
    autoload :StructFactory
    autoload :WideChar
  end
end
