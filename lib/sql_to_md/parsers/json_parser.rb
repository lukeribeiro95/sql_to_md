# frozen_string_literal: true

require 'json'
require_relative 'base'

module SqlToMd
  module Parsers
    class JsonParser < Base
      def parse
        JSON.parse(@content, symbolize_names: true)
      rescue JSON::ParserError
        raise SqlToMd::Error, 'O arquivo não é um JSON válido.'
      end
    end
  end
end
