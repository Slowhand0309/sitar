# coding: utf-8
require 'fiddle'
require 'fiddle/import'

module Sitar
  module Binder
    extend Fiddle::Importer

    class << self

      def execute(name, *args)
        func = bind_method(name, *args)
        if func
          return func.call(*args)
        end
        nil
      end

      def bind_method(name, *args)
        func = nil
        begin
          addr = handler.sym(name.to_s)
          argv = parse_arguments(*args)
          func = Fiddle::Function.new(addr, argv, Fiddle::TYPE_INT)
        rescue Fiddle::DLError => e
          puts e
        end
        func
      end

      def parse_arguments(*args)
        values = *args
        # No argument.
        if values.length == 0
          return [Fiddle::TYPE_VOID]
        end

        argv = []
        values.each do |arg|
          # Decide arg type.
          if arg.kind_of?(Integer)
            argv << Fiddle::TYPE_INT
          elsif arg.kind_of?(String)
            argv << Fiddle::TYPE_VOIDP
          end
        end
        argv
      end

    end

  end
end
