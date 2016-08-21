# coding: utf-8
require 'fiddle/import'
require 'sitar/types/wide_char'

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

    # === Description
    #
    # Call function with no returned value.
    def call
      func = get_func(Fiddle::TYPE_VOID)
      if func
        func.call(*@args)
      end
    end

    # === Description
    #
    # Call function with integer returned value.
    # If failed call, returned -1.
    def ret_i
      result = -1
      func = get_func(Fiddle::TYPE_LONG)
      if func
        result = func.call(*@args).to_i
      end
      result
    end

    # === Description
    #
    # Call function with (char *) returned value.
    # If failed call, returned ''.
    def ret_s
      result = ''
      func = get_func(Fiddle::TYPE_LONG)
      if func
        result = Fiddle::Pointer.new(func.call(*@args)).to_s
      end
      result
    end

    # === Description
    #
    # Call function with (wchar_t *) returned value.
    # If failed call, returned ''.
    def ret_ws
      result = ''
      func = get_func(Fiddle::TYPE_LONG)
      if func
        result = Types::WideChar.from_ptr(func.call(*@args))
      end
      result
    end

    # === Description
    #
    # Call function with float returned value.
    # If failed call, returned 0.0.
    def ret_f
      result = 0.0
      func = get_func(Fiddle::TYPE_FLOAT)
      if func
        result = func.call(*@args).to_f
      end
      result
    end

    # === Description
    #
    # Call function with double returned value.
    # If failed call, returned 0.0.
    def ret_d
      result = 0.0
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
