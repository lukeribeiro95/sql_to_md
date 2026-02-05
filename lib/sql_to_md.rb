# frozen_string_literal: true

# lib/sql_to_md.rb
require_relative "sql_to_md/version"
# Módulo principal que converte dados para Markdown
module SqlToMd
  class Error < StandardError; end

  # Esse é o método que o usuário vai chamar: SqlToMd.convert(dados)
  def self.convert(data)
    # Se a lista estiver vazia, retorna uma string vazia para não quebrar
    return "" if data.empty?

    # 1. Pega as chaves do primeiro item para fazer o cabeçalho (ex: id, name, email)
    headers = data.first.keys

    # 2. Monta a linha do cabeçalho
    # O .join(' | ') junta os itens colocando uma barra entre eles
    header_line = "| #{headers.join(' | ')} |"

    # 3. Monta a linha separadora (aquela com ---)
    # O .map transforma cada cabeçalho em '---'
    separator_line = "| #{headers.map { '---' }.join(' | ')} |"

    # 4. Monta as linhas de dados
    body_lines = data.map do |row|
      # row.values pega só os valores do hash (sem as chaves)
      "| #{row.values.join(' | ')} |"
    end

    # 5. Junta tudo: Cabeçalho + Separador + Linhas de dados
    # O "\n" é a quebra de linha
    ([header_line, separator_line] + body_lines).join("\n")
  end
end
