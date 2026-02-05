# SQL to Markdown (sql_to_md)

![Ruby CI](https://github.com/lukeribeiro95/sql_to_md/actions/workflows/main.yml/badge.svg)

Uma ferramenta CLI (Linha de Comando) robusta para converter arrays de dados (estilo SQL/JSON) em tabelas Markdown perfeitamente formatadas. Ideal para documentação técnica e relatórios rápidos.

## 🚀 Funcionalidades

- **Conversão Automática:** Transforma listas de Hashes Ruby/JSON em tabelas Markdown.
- **Formatação Inteligente:** Ajusta automaticamente a largura das colunas baseada no conteúdo.
- **CLI Intuitiva:** Interface de linha de comando simples e direta.
- **Docker Ready:** Roda em qualquer sistema operacional sem necessidade de instalar Ruby ou configurar ambiente.
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

---

## 💎 Como Usar (Instalação Local)

Se você é um desenvolvedor Ruby e prefere rodar nativamente:

1. Instale as dependências:
   ```bash
   bundle install
   ```

2. Execute o comando:
   ```bash
   ruby bin/sql2md convert dados.json
   ```

---

## 🛠 Desenvolvimento e Testes

Este projeto segue as melhores práticas de engenharia de software moderna.

- **Testes Automatizados:** RSpec
- **Linter / Estilo:** RuboCop
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