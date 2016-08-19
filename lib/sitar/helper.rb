# coding: utf-8

module Sitar
  class Helper

    class << self

      # Platform to check whether windows.
      #
      # === Return
      # If return true, platform is windows.
      def platform_windows?
        RUBY_PLATFORM =~ /cygwin|mswin|mingw|bccwin|wince|emx/
      end

      # Platform to check whether mac os.
      #
      # === Return
      # If return true, platform is mac os.
      def platform_mac?
        RUBY_PLATFORM =~ /darwin/
      end

      # Platform to check whether linux.
      #
      # === Return
      # If return true, platform is linux.
      def platform_linux?
        RUBY_PLATFORM =~ /linux/
      end
    end

  end
end
