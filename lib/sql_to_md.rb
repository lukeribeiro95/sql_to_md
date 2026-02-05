# frozen_string_literal: true

require_relative 'sql_to_md/version'
require_relative 'sql_to_md/parsers/json_parser'
require_relative 'sql_to_md/parsers/csv_parser'

module SqlToMd
  class Error < StandardError; end

  class Converter
    def initialize(file_path)
      @file_path = file_path
      @extension = File.extname(file_path).downcase
      @content = File.read(file_path)
    end

    def call
      # 1. Escolhe a estratégia baseada na extensão
      parser = select_parser

      # 2. Processa os dados
      data = parser.new(@content).parse

      # 3. Formata (retorna string vazia se não tiver dados)
      return '' if data.empty?

      format_markdown(data)
    end

    private

    def select_parser
      case @extension
      when '.json' then Parsers::JsonParser
      when '.csv'  then Parsers::CsvParser
      else
        raise Error, "Formato '#{@extension}' não suportado."
      end
    end

    def format_markdown(data)
      headers = data.first.keys
      rows = data.map(&:values)
      sizes = calculate_column_sizes(headers, rows)

      build_table(headers, rows, sizes)
    end

    def calculate_column_sizes(headers, rows)
      sizes = headers.map { |h| h.to_s.length }
      rows.each do |row|
        row.each_with_index do |cell, i|
          sizes[i] = [sizes[i], cell.to_s.length].max
        end
      end
      sizes
    end

    def build_table(headers, rows, sizes)
      lines = []
      lines << build_row(headers, sizes)
      lines << build_separator(sizes)
      rows.each { |row| lines << build_row(row, sizes) }
      lines.join("\n")
    end

    def build_row(cells, sizes)
      row = cells.map.with_index { |c, i| " #{c.to_s.ljust(sizes[i])} " }
      "|#{row.join('|')}|"
    end

    def build_separator(sizes)
      sep = sizes.map { |s| " #{'-' * s} " }
      "|#{sep.join('|')}|"
    end
  end
end
