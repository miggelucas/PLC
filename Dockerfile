# --- ESTÁGIO 1: Builder ---
FROM swift:6.0-jammy AS builder

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos de manifesto primeiro para aproveitar o cache do Docker.
# O build só será refeito se esses arquivos mudarem.
COPY Package.swift Package.resolved ./

# Resolve as dependências do projeto
RUN swift package resolve

# Copia todo o resto do código-fonte
COPY . .

# Compila o projeto em modo "release" para otimização e performance.
# O executável será criado em .build/release/
RUN swift build -c release

# --- ESTÁGIO 2: Runner ---
# Começamos com uma imagem base limpa e leve do Ubuntu.
FROM ubuntu:22.04

# Define o diretório de trabalho
WORKDIR /app

# Instala as dependências de runtime do Swift.
# Isso garante que todas as bibliotecas .so necessárias estejam presentes.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libatomic1 \
    libcurl4 \
    libxml2 \
    libicu70 \
    libssl3 && \
    rm -rf /var/lib/apt/lists

# Copia as bibliotecas de runtime do Swift do estágio de build.
# Isso é mais confiável do que instalá-las separadamente.
COPY --from=builder /usr/lib/swift/linux/*.so* /usr/lib/swift/linux/

# --- Ponto crucial: Copia APENAS o binário compilado do estágio builder ---
# Substitua "NomeDoSeuExecutavel" pelo nome do seu target executável
# Você pode encontrar esse nome no seu arquivo Package.swift, na seção `executableTarget(name: "...")`
COPY --from=builder /app/.build/release/FST .

# Define o comando que será executado quando o contêiner iniciar.
# O contêiner se comportará exatamente como o seu executável.
ENTRYPOINT ["./FST"]

# (Opcional) Define um comando padrão, como mostrar a ajuda.
CMD ["--help"]
