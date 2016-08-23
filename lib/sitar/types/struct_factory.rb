# coding: utf-8
require 'fiddle/import'

module Sitar
  module Types

    class StructFactory


      def create(struct_name, members)
        @structs ||= {}
        @structs[struct_name] = members
      end

      def parse(members)
        members.each do |member|
          # TODO parse
        end
      end

      def build
        struct(members)
      end

    end

  end
end
