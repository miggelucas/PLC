# Dockerfile para uma CLI em Swift usando multi-stage build.

# --- ESTÁGIO 1: Ambiente de Build ---
# Utiliza a imagem oficial do Swift, que contém todo o SDK necessário para compilação.
FROM swift:6.0-jammy AS builder

# Define o diretório de trabalho padrão.
WORKDIR /app

# Copia os manifestos do pacote para otimizar o cache de layers do Docker.
# As dependências só serão baixadas novamente se estes arquivos mudarem.
COPY Package.swift Package.resolved ./

# Resolve e baixa as dependências do Swift Package Manager.
RUN swift package resolve

# Copia o restante do código-fonte para o contêiner.
COPY . .

# Compila o executável em modo 'release' para máxima otimização.
RUN swift build -c release

# --- ESTÁGIO 2: Ambiente de Execução ---
# Utiliza uma imagem base do Ubuntu para a imagem final, resultando em um tamanho menor.
FROM ubuntu:22.04

# Define o diretório de trabalho para o ambiente de execução.
WORKDIR /app

# Instala as shared libraries de sistema que são dependências do Swift runtime.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libatomic1 \
    libcurl4 \
    libxml2 \
    libicu70 \
    libssl3 && \
    rm -rf /var/lib/apt/lists/*

# Copia as bibliotecas de runtime específicas do Swift a partir do estágio de build.
COPY --from=builder /usr/lib/swift/linux/*.so* /usr/lib/swift/linux/

# Copia apenas o binário compilado do estágio de build para a imagem final.
COPY --from=builder /app/.build/release/FST .

# Define o executável como o entrypoint do contêiner, permitindo que a imagem
# seja tratada como o próprio executável.
ENTRYPOINT ["./FST"]

# Define um comando padrão a ser executado se nenhum for fornecido ao 'docker run'.
# É uma boa prática exibir a mensagem de ajuda.
CMD ["--help"]