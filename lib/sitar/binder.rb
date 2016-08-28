# coding: utf-8
require 'fiddle'
require 'fiddle/import'
require 'sitar/executor'
require 'sitar/types'

module Sitar
  module Binder
    extend Fiddle::Importer

    class << self

      # Bind at function.
      #
      # * +name+ is the function name
      # * +args+ is the function args
      #
      # Return the executor class instance.
      def at(name, *args)
        address = nil
        argv = []
        begin
          address = handler.sym(name.to_s)
          argv = parse_arguments(*args)
        rescue Fiddle::DLError => e
          $stderr.puts "Fiddle::DLError #{e}"
        end
        if address
          Executor.new(address, argv, *args)
        else
          nil # If invalid symbol name, return nil.
        end
      end

      def typealias_ext
        include Types::Aliases
      end

      def parse_arguments(*args)
        values = *args
        # No have argument.
        if values.length == 0
          return []
        end

        argv = []
        values.each do |arg|
          # Decide arg type.
          if arg.kind_of?(Integer)
            argv << Fiddle::TYPE_INT
          elsif arg.kind_of?(Float)
            argv << Fiddle::TYPE_DOUBLE
          elsif arg.kind_of?(String)
            argv << Fiddle::TYPE_VOIDP
          elsif arg.kind_of?(Fiddle::Pointer)
            argv << Fiddle::TYPE_VOIDP
          else
            argv << Fiddle::TYPE_VOIDP
          end
        end
        argv
      end

    end

  end
end
