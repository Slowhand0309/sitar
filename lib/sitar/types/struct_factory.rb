# coding: utf-8
require 'fiddle/import'

module Sitar
  module Types

    class StructFactory


      def create(struct_name, members)
        @structs ||= {}
        @structs[struct_name] = members
      end

      def build
        @structs.each do |k, v|
          # TODO declare struct name
          struct(parse(v))
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
            tmp = member
            # Parse inner struct.
            type = member.split(' ')[0]
            inner_struct = @structs[type]
            if inner_struct
              value = member.split(' ')[1]
              count = 1
              if /\[(\d+)\]/ =~ value
                count = $1.to_i
              end
              tmp << parse_inner_struct(count, inner_struct)
            end
            inners << tmp
          end
        end
        inners.flatten
      end

    end

  end
end
