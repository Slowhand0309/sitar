# coding: utf-8
require 'fiddle/import'

module Sitar
  class Executor

    def initialize(address, argv, *args)
      @address = address
      @argv = argv
      @args = args
    end

    def to_i
      func = Fiddle::Function.new(@address, @argv, Fiddle::TYPE_LONG)
      func.call(*@args).to_i
    end

    def to_s
      func = Fiddle::Function.new(@address, @argv, Fiddle::TYPE_LONG)
      Fiddle::Pointer.new(func.call(*@args)).to_s
    end

    def to_f
      func = Fiddle::Function.new(@address, @argv, Fiddle::TYPE_DOUBLE)
      func.call(*@args).to_f
    end

  end
end
