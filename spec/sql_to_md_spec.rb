# frozen_string_literal: true

# spec/sql_to_md_spec.rb
RSpec.describe SqlToMd do
  it "tem um número de versão" do
    expect(SqlToMd::VERSION).not_to be nil
  end

  it "converte uma lista de hashes em tabela Markdown" do
    # DADOS DE ENTRADA (Simulando um banco de dados)
    input = [
      { id: 1, nome: "Ruby", tipo: "Linguagem" },
      { id: 2, nome: "Rails", tipo: "Framework" }
    ]

    # O QUE ESPERAMOS DE SAÍDA
    expected = "| id | nome | tipo |\n" \
               "| --- | --- | --- |\n" \
               "| 1 | Ruby | Linguagem |\n" \
               "| 2 | Rails | Framework |"

    # O TESTE: "Espero que converter o input seja igual ao expected"
    expect(SqlToMd.convert(input)).to eq(expected)
  end

  it "retorna string vazia se não houver dados" do
    expect(SqlToMd.convert([])).to eq("")
  end
end
