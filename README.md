# Formula Solver (PLC)

Um resolvedor de fórmulas poderoso e flexível para Swift, com suporte a operações lógicas e matemáticas, além de uma ferramenta de linha de comando.

## 📋 Índice

- [Visão Geral](#visão-geral)
- [Funcionalidades](#funcionalidades)
- [Instalação](#instalação)
- [Uso](#uso)
  - [Como Biblioteca](#como-biblioteca)
  - [Linha de Comando](#linha-de-comando)
- [Operações Disponíveis](#operações-disponíveis)
- [Exemplos](#exemplos)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Testes](#testes)
- [Requisitos](#requisitos)

## 🎯 Visão Geral

O **Formula Solver** é uma biblioteca Swift que permite avaliar e resolver fórmulas complexas com suporte a:

- Operações lógicas (AND, OR, NOT, IF, EQ)
- Operações matemáticas (SUM)
- Fórmulas aninhadas
- Referências de variáveis com contexto
- Tipos de dados múltiplos (Boolean, Number, String)

## ✨ Funcionalidades

- **Parser de Fórmulas**: Converte strings em estruturas de dados que representam fórmulas
- **Avaliador de Expressões**: Executa operações e retorna resultados
- **Suporte a Contexto**: Permite passar variáveis externas para as fórmulas
- **Validação de Sintaxe**: Verifica se uma fórmula é válida antes de executá-la
- **CLI Tool**: Interface de linha de comando para resolver fórmulas rapidamente
- **Type-Safe**: Sistema de tipos robusto com validação de argumentos

## 📦 Instalação

### Como Dependência Swift Package

Adicione ao seu `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/miggelucas/PLC.git", from: "1.0.0")
]
```

E então adicione `FormulaSolver` aos targets:

```swift
.target(
    name: "MeuApp",
    dependencies: ["FormulaSolver"]
)
```

### Ferramenta de Linha de Comando

Clone o repositório e compile:

```bash
git clone https://github.com/miggelucas/PLC.git
cd PLC
swift build -c release
```

O executável estará em `.build/release/FST`.

## 🚀 Uso

### Como Biblioteca

#### Exemplo Básico

```swift
import FormulaSolver

let solver = FormulaSolver()

// Resolver uma fórmula simples
let result = try solver.solveFormula("SUM(1; 2; 3)")
print(result) // "6.0"
```

#### Fórmulas Lógicas

```swift
// Operação AND
let andResult = try solver.solveFormula("AND(TRUE; TRUE)")
print(andResult) // "TRUE"

// Operação OR
let orResult = try solver.solveFormula("OR(FALSE; TRUE)")
print(orResult) // "TRUE"

// Operação NOT
let notResult = try solver.solveFormula("NOT(FALSE)")
print(notResult) // "TRUE"
```

#### Fórmulas com Contexto

```swift
let context = [
    "idade": "25",
    "temCarro": "TRUE",
    "salario": "5000"
]

let formula = "AND(EQ(idade; 25); temCarro)"
let result = try solver.solveFormula(formula, context: context)
print(result) // "TRUE"
```

#### Fórmulas Aninhadas

```swift
let formula = "IF(AND(TRUE; OR(FALSE; TRUE)); SUM(10; 20); 0)"
let result = try solver.solveFormula(formula)
print(result) // "30.0"
```

### Linha de Comando

A ferramenta de linha de comando (FST - Formula Solver Tool) fornece duas funcionalidades principais:

#### Resolver Fórmulas

```bash
# Sintaxe básica
./FST solve "SUM(1; 2; 3)"
# 🔍 Calculando a fórmula: SUM(1; 2; 3)
# ✅ Resultado: 6.0

# Operações lógicas
./FST solve "AND(TRUE; OR(FALSE; TRUE))"
# ✅ Resultado: TRUE

# Fórmulas complexas
./FST solve "IF(EQ(10; 10); SUM(5; 5); 0)"
# ✅ Resultado: 10.0
```

#### Validar Fórmulas

```bash
./FST validate "AND(TRUE; FALSE)"
# 🔎 Validando a fórmula: AND(TRUE; FALSE)
# ✅ A fórmula é válida.
```

#### Ajuda

```bash
./FST --help
# Exibe todas as opções disponíveis

./FST solve --help
# Exibe ajuda específica do comando solve
```

## 🔧 Operações Disponíveis

### Operações Lógicas

| Operação | Descrição | Sintaxe | Exemplo |
|----------|-----------|---------|---------|
| `AND` | E lógico - retorna TRUE se todos os argumentos forem TRUE | `AND(arg1; arg2; ...)` | `AND(TRUE; TRUE)` → `TRUE` |
| `OR` | OU lógico - retorna TRUE se pelo menos um argumento for TRUE | `OR(arg1; arg2; ...)` | `OR(FALSE; TRUE)` → `TRUE` |
| `NOT` | NÃO lógico - inverte o valor booleano | `NOT(arg)` | `NOT(FALSE)` → `TRUE` |
| `IF` | Condicional - retorna um valor baseado em uma condição | `IF(condição; valorSeVerdadeiro; valorSeFalso)` | `IF(TRUE; 10; 20)` → `10` |
| `EQ` | Igualdade - verifica se dois valores são iguais | `EQ(arg1; arg2)` | `EQ(5; 5)` → `TRUE` |

### Operações Matemáticas

| Operação | Descrição | Sintaxe | Exemplo |
|----------|-----------|---------|---------|
| `SUM` | Soma - adiciona todos os argumentos numéricos | `SUM(arg1; arg2; ...)` | `SUM(1; 2; 3)` → `6.0` |

### Tipos de Dados Suportados

- **Boolean**: `TRUE`, `FALSE`
- **Number**: Números inteiros e decimais (ex: `42`, `3.14`)
- **String**: Texto entre aspas duplas (ex: `"hello"`)
- **Reference**: Nome de variável do contexto (ex: `idade`, `nome`)
- **NestedFormula**: Fórmulas dentro de outras fórmulas

## 📚 Exemplos

### Exemplo 1: Validação de Elegibilidade

```swift
let context = [
    "idade": "18",
    "temDocumento": "TRUE",
    "aprovado": "TRUE"
]

let formula = "AND(EQ(idade; 18); AND(temDocumento; aprovado))"
let result = try solver.solveFormula(formula, context: context)
// Resultado: "TRUE"
```

### Exemplo 2: Cálculo Condicional

```swift
let context = [
    "temDesconto": "TRUE",
    "valorOriginal": "100"
]

let formula = "IF(temDesconto; SUM(valorOriginal; -20); valorOriginal)"
let result = try solver.solveFormula(formula, context: context)
// Resultado: "80.0"
```

### Exemplo 3: Fórmulas Complexas Aninhadas

```swift
let context = [
    "A1": "10",
    "B1": "20",
    "C1": "30",
    "condicao": "TRUE"
]

let formula = "IF(condicao; SUM(A1; B1; C1); 0)"
let result = try solver.solveFormula(formula, context: context)
// Resultado: "60.0"
```

### Exemplo 4: Comparações e Lógica

```swift
let formula = "OR(EQ(5; 5); AND(FALSE; TRUE))"
let result = try solver.solveFormula(formula)
// Resultado: "TRUE"
```

### Exemplo 5: Strings em Fórmulas

```swift
let context = [
    "nome": "\"Lucas\"",
    "nomeEsperado": "\"Lucas\""
]

let formula = "EQ(nome; nomeEsperado)"
let result = try solver.solveFormula(formula, context: context)
// Resultado: "TRUE"
```

## 🏗️ Estrutura do Projeto

```
PLC/
├── Sources/
│   ├── FormulaSolver/          # Biblioteca principal
│   │   ├── Formula/            # Parser e resolver de fórmulas
│   │   │   ├── FormulaSolver.swift
│   │   │   ├── FormulaParser.swift
│   │   │   ├── Model/
│   │   │   │   ├── Formula.swift
│   │   │   │   └── Value.swift
│   │   │   ├── Protocols/
│   │   │   └── Error/
│   │   ├── Operation/          # Implementações de operações
│   │   │   ├── Logic/          # Operações lógicas
│   │   │   ├── Math/           # Operações matemáticas
│   │   │   ├── Protocols/
│   │   │   ├── Factory/
│   │   │   └── Error/
│   │   └── Extensions/         # Extensões úteis
│   └── FST/                    # Ferramenta de linha de comando
│       ├── FormulaSolverTool.swift
│       └── SubCommands/
│           ├── Solve.swift
│           └── Validate.swift
└── Tests/
    └── FormulaSolverTests/     # Testes unitários
```

## 🧪 Testes

O projeto inclui testes abrangentes para todas as funcionalidades:

```bash
# Executar todos os testes
swift test

# Executar testes com verbosidade
swift test --verbose
```

### Cobertura de Testes

- ✅ Parser de fórmulas
- ✅ Todas as operações lógicas
- ✅ Todas as operações matemáticas
- ✅ Resolução de fórmulas com contexto
- ✅ Fórmulas aninhadas
- ✅ Validação de tipos
- ✅ Tratamento de erros

## 📋 Requisitos

- Swift 6.0 ou superior
- macOS 13+ / Linux com Swift instalado

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer fork do projeto
2. Criar uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abrir um Pull Request

## 📄 Licença

Este projeto está sob uma licença de código aberto. Consulte o arquivo LICENSE para mais detalhes.

## ✍️ Autores

- Lucas Migge
- Lucas Barros

## 🐛 Reportar Problemas

Se você encontrar algum problema ou tiver sugestões, por favor abra uma [issue](https://github.com/miggelucas/PLC/issues) no GitHub.
