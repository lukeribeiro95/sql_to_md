# frozen_string_literal: true

module SqlToMd
  module Parsers
    class Base
      def initialize(content)
        @content = content
      end

      def parse
        raise NotImplementedError, "Plugin mal configurado: implemente o método 'parse'"
      end
    end
  end
end
