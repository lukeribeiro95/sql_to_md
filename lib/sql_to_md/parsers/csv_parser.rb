# frozen_string_literal: true

require "csv"
require_relative "base"

module SqlToMd
  module Parsers
    class CsvParser < Base
      def parse
        # Converte CSV para lista de Hashes (igual ao JSON)
        CSV.parse(@content, headers: true).map(&:to_h)
      rescue CSV::MalformedCSVError
        raise SqlToMd::Error, "O arquivo não é um CSV válido."
      end
    end
  end
end
