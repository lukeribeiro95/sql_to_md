# SQL to Markdown (sql_to_md)

![Ruby CI](https://github.com/lukeribeiro95/sql_to_md/actions/workflows/main.yml/badge.svg)

Uma ferramenta CLI (Linha de Comando) robusta e extensível para converter dados brutos (**JSON** e **CSV**) em tabelas Markdown perfeitamente formatadas.

Ideal para desenvolvedores que precisam gerar relatórios técnicos, documentação de APIs ou migrar dados de planilhas para documentação (GitHub/Jira/Notion) em segundos.

## 🚀 Funcionalidades

- **Multi-Formato:** Suporte nativo para arquivos `.json` e `.csv`.
- **Arquitetura Plugável:** Design baseado em Plugins (Strategy Pattern), facilitando a adição de novos formatos (XML, YAML, etc) sem alterar o núcleo.
- **UX Aprimorada:** Feedback visual com barras de progresso (spinners) e mensagens coloridas no terminal.
- **Formatação Inteligente:** Ajusta automaticamente a largura das colunas baseada no conteúdo.
- **Docker Ready:** Roda em container isolado, sem poluir seu sistema.
- **Alta Qualidade:** Código testado (RSpec), padronizado (RuboCop) e com CI/CD configurado.

---

## 📦 Como Usar (Via Docker) - Recomendado

Este é o método mais fácil. Não requer instalação de Ruby no seu computador.

### 1. Construir a imagem (apenas na primeira vez)
```bash
docker build -t sql_to_md .
```

### 2. Rodar a conversão
Suponha que você tenha um arquivo `dados.json` na sua pasta atual.

**No Windows (PowerShell):**
```powershell
docker run --rm -v ${PWD}:/app sql_to_md ruby bin/sql2md convert dados.json
```

**No Linux ou Mac:**
```bash
docker run --rm -v "$(pwd):/app" sql_to_md ruby bin/sql2md convert dados.json
```

**Exemplo com CSV**
**Windows (PowerShell)**
```bash
docker run --rm -v ${PWD}:/app sql_to_md ruby bin/sql2md convert planilha.csv
```
---

## 💎 Como Usar (Instalação Local)

Se você é um desenvolvedor Ruby e prefere rodar nativamente:

1. Instale as dependências:
   ```bash
   bundle install
   ```

2. Execute o comando:
   # Para arquivos JSON
   ```bash
   ruby bin/sql2md convert dados.json
   ```
   # Para arquivos CSV
   ```bash
   bundle exec ruby bin/sql2md convert planilha.csv
   ```
---

## 🛠 Desenvolvimento e Testes

Este projeto foi construído simulando um ambiente Enterprise, com foco em extensibilidade, manutenção e SOLID.
Padrões de Projeto (Design Patterns) utilizados:

   - **Strategy Pattern:** Isolamento da lógica de leitura de cada formato (Parsers::JsonParser, Parsers::CsvParser), respeitando o princípio Open/Closed.

   - **Factory Pattern:** Instanciação dinâmica do parser correto baseado na extensão do arquivo.

   - **Service Object:** A lógica de negócio está desacoplada da interface CLI.

- **Stack Tecnológica:**

   - **Linguagem:** Ruby 3.x
   - **Testes Automatizados:** RSpec (TDD)
   - **Linter:** RuboCop (Style Guide)
   - **CLI:** Thor & TTY-Spinner
   - **CI/CD:** GitHub Actions (Roda testes a cada push)

### Rodando os testes (RSpec)

Via Docker (Limpo e Isolado):
```bash
docker run --rm sql_to_md bundle exec rspec
```

Localmente:
```bash
bundle exec rspec
```

### Verificando o estilo (RuboCop)
```bash
bundle exec rubocop
```

## 📄 Licença

O código está disponível como código aberto sob os termos da [Licença MIT](https://opensource.org/licenses/MIT).