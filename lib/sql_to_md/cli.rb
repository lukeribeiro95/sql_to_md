# frozen_string_literal: true

require 'thor'
require 'json'
require 'sql_to_md'

module SqlToMd
  # Interface de Linha de Comando (CLI) usando Thor
  class CLI < Thor
    desc 'convert ARQUIVO', 'Lê um arquivo JSON e mostra uma tabela Markdown'
    def convert(path)
      # 1. Lê o arquivo que o usuário passou
      file_content = File.read(path)
      data = JSON.parse(file_content, symbolize_names: true)

      # 2. Usa sua lógica para converter
      markdown = SqlToMd.convert(data)

      # 3. Imprime no terminal
      puts markdown
    rescue Errno::ENOENT
      puts "❌ Erro: Arquivo '#{path}' não encontrado."
    rescue JSON::ParserError
      puts '❌ Erro: O arquivo não é um JSON válido.'
    end
  end
end
