# frozen_string_literal: true

require "sql_to_md"

RSpec.describe SqlToMd do
  it "tem um número de versão" do
    expect(SqlToMd::VERSION).not_to be nil
  end
end

# Testando a Classe Converter (A Gerente)
RSpec.describe SqlToMd::Converter do
  describe "#call" do
    # Contexto 1: Arquivos JSON
    context "quando o arquivo é JSON" do
      let(:file_path) { "dados.json" }
      let(:json_content) { '[{"Nome": "Lucas", "Role": "Dev"}]' }

      before do
        # MOCK: Fingimos que o arquivo existe e tem conteúdo
        # Isso evita criar arquivos reais no disco durante o teste
        allow(File).to receive(:read).with(file_path).and_return(json_content)
        allow(File).to receive(:extname).with(file_path).and_return(".json")
      end

      it "converts JSON data to Markdown table correctly" do
        converter = described_class.new(file_path)
        result = converter.call

        # Verifica se o resultado contem partes da tabela Markdown
        expect(result).to include("| Nome  | Role |")
        expect(result).to include("|-------|------|")
        expect(result).to include("| Lucas | Dev  |")
      end
    end

    # Contexto 2: Arquivos CSV
    context "quando o arquivo é CSV" do
      let(:file_path) { "dados.csv" }
      let(:csv_content) { "Nome,Role\nLucas,Dev" }

      before do
        allow(File).to receive(:read).with(file_path).and_return(csv_content)
        allow(File).to receive(:extname).with(file_path).and_return(".csv")
      end

      it "converts CSV data to Markdown table correctly" do
        converter = described_class.new(file_path)
        result = converter.call

        expect(result).to include("| Nome  | Role |")
        expect(result).to include("|-------|------|")
        expect(result).to include("| Lucas | Dev  |")
      end
    end

    # Contexto 3: Tratamento de Erro
    context "quando o formato não é suportado" do
      let(:file_path) { "imagem.png" }

      before do
        allow(File).to receive(:read).with(file_path).and_return("")
        allow(File).to receive(:extname).with(file_path).and_return(".png")
      end

      it "luança um erro específico" do
        expect {
          described_class.new(file_path).call
        }.to raise_error(SqlToMd::Error, /não suportado/)
      end
    end
  end
end