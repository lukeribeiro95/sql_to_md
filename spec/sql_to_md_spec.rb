# frozen_string_literal: true

require 'sql_to_md'

RSpec.describe SqlToMd do
  it 'has a version number' do
    expect(SqlToMd::VERSION).not_to be_nil
  end

  describe 'Converter' do
    subject(:converter) { SqlToMd::Converter.new(file_path) }

    describe '#call' do
      context 'when the file is JSON' do
        let(:file_path) { 'data.json' }
        let(:json_content) { '[{"Name": "Lucas", "Role": "Dev"}]' }

        before do
          allow(File).to receive(:read).with(file_path).and_return(json_content)
          allow(File).to receive(:extname).with(file_path).and_return('.json')
        end

        # :aggregate_failures permite varios expects no mesmo bloco sem o RuboCop reclamar
        it 'converts JSON data to Markdown table correctly', :aggregate_failures do
          result = converter.call

          expect(result).to include('| Name  | Role |')
          expect(result).to include('| ----- | ---- |')
          expect(result).to include('| Lucas | Dev  |')
        end
      end

      context 'when the file is CSV' do
        let(:file_path) { 'data.csv' }
        let(:csv_content) { "Name,Role\nLucas,Dev" }

        before do
          allow(File).to receive(:read).with(file_path).and_return(csv_content)
          allow(File).to receive(:extname).with(file_path).and_return('.csv')
        end

        it 'converts CSV data to Markdown table correctly', :aggregate_failures do
          result = converter.call

          expect(result).to include('| Name  | Role |')
          expect(result).to include('| ----- | ---- |')
          expect(result).to include('| Lucas | Dev  |')
        end
      end

      context 'when the format is not supported' do
        let(:file_path) { 'image.png' }

        before do
          allow(File).to receive(:read).with(file_path).and_return('')
          allow(File).to receive(:extname).with(file_path).and_return('.png')
        end

        it 'raises a specific error' do
          expect { converter.call }.to raise_error(SqlToMd::Error, /não suportado/)
        end
      end
    end
  end
end
