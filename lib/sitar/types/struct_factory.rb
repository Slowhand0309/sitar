# coding: utf-8
require 'fiddle/import'

module Sitar
  module Types

    module StructFactory

      # Define struct.
      #
      # == Example
      #
      # module M
      #   extend Sitar::Types::StructFactory
      #
      #   define 'struct', ["int no", "char *name"]
      # end
      def define(struct_name, members)
        @structs ||= {}
        @structs[struct_name] = members
      end

      # Apply struct via define method.
      def define_eval(m)
        @structs.each do |k, v|
          # Declare struct.
          name = k.upcase
          members = parse(k, v)
          m.module_eval <<-EOF
             #{name} = struct(#{members})
          EOF
        end
      end

      private

      def parse(struct_name, members)
        parse_inner_struct(1, struct_name, members)
      end

      def parse_inner_struct(count, struct_name, members)
        inners = []
        1.upto count do |idx|
          members.each do |member|
            # Parse inner struct.
            type = member.split(' ')[0]
            value = member.split(' ')[1]

            inner_struct = @structs[type]
            if type != struct_name && inner_struct
              array_count = 1
              if /\[(\d+)\]/ =~ value
                array_count = $1.to_i
              end
              inners << parse_inner_struct(array_count, type, inner_struct)
            else
              if count > 1
                # Add member prefix. XX_1, XX_2
                if /([a-zA-Z]+)\[(\d+)\]/ =~ value
                  # Replace XXX[20] -> XXX_1[20]
                  value = "#{$1}_#{idx}[#{$2}]"
                else
                  value = "#{value}_#{idx}"
                end

                inners << "#{type} #{value}"
              else
                inners << member
              end
            end
          end
        end
        inners.flatten
      end

    end

  end
end
