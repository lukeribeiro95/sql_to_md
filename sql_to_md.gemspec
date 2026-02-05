# frozen_string_literal: true

require_relative "lib/sql_to_md/version"

Gem::Specification.new do |spec|
  spec.name = "sql_to_md"
  spec.version = SqlToMd::VERSION
  spec.authors = ["Lucas"]
  spec.email = ["lucas_ribeiro95@hotmail.com"]

  spec.summary = "Converte SQL Array para tabelas Markdown."
  spec.description = "Uma CLI e biblioteca para formatar dados JSON/SQL em tabelas Markdown."
  spec.homepage = "https://github.com/lukeribeiro95/sql_to_md"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Configuração dos arquivos que entram no pacote da Gem
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end

  # Configuração do executável (CLI)
  spec.bindir = "bin"
  spec.executables = ["sql2md"]
  spec.require_paths = ["lib"]

  # Dependências (Ordem alfabética para o RuboCop não reclamar)
  spec.add_dependency "csv"
  spec.add_dependency "pastel"
  spec.add_dependency "json"
  spec.add_dependency "thor"
  spec.add_dependency "tty-spinner"
end
