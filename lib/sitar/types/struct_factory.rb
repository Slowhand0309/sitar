# coding: utf-8
require 'fiddle/import'

module Sitar
  module Types

    module StructFactory


      def define(struct_name, members)
        @structs ||= {}
        @structs[struct_name] = members
      end

      def define_eval(m)
        @structs.each do |k, v|
          # Declare struct.
          name = k.upcase
          members = parse(v)
          m.module_eval <<-EOF
             #{name} = struct(#{members})
          EOF
        end
      end

      private

      def parse(members)
        parse_inner_struct(1, members)
      end

      def parse_inner_struct(count, members)
        inners = []
        count.times do
          members.each do |member|
            # Parse inner struct.
            type = member.split(' ')[0]
            inner_struct = @structs[type]
            if inner_struct
              value = member.split(' ')[1]
              count = 1
              if /\[(\d+)\]/ =~ value
                count = $1.to_i
              end
              inners << parse_inner_struct(count, inner_struct)
            else
              inners << member
            end
          end
        end
        inners.flatten
      end

    end

  end
end
