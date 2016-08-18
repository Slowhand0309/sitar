# coding: utf-8
require 'fiddle/import'

module Sitar
  class Executor

    # === Description
    #
    # Construct new object.
    #
    # * +address+ is the shared library memory address.
    def initialize(address, argv, *args)
      @address = address
      @argv = argv
      @args = args
    end

    def run
      func = get_func(Fiddle::TYPE_VOID)
      if func
        func.call(*@args)
      end
    end

    def to_i
      result = -1 # Return -1, if invalid 'to_i' method.
      func = get_func(Fiddle::TYPE_LONG)
      if func
        result = func.call(*@args).to_i
      end
      result
    end

    def to_s
      result = '' # Return empty string, if invalid 'to_s' method.
      func = get_func(Fiddle::TYPE_LONG)
      if func
        result = Fiddle::Pointer.new(func.call(*@args)).to_s
      end
      result
    end

    def to_f
      result = 0.0 # Return 0.0, if invalid 'to_f' method.
      func = get_func(Fiddle::TYPE_DOUBLE)
      if func
        result = func.call(*@args).to_f
      end
      result
    end

    private

    def get_func(type)
      unless @address
        return nil
      end
      Fiddle::Function.new(@address, @argv, type)
    end
  end
end
