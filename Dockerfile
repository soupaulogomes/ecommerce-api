# Etapa 1: build da aplicação
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia arquivos de projeto e restaura dependências
COPY *.csproj ./
RUN dotnet restore

# Copia o restante do código e publica a aplicação
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: imagem final mais enxuta
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copia os arquivos da pasta publicada no build
COPY --from=build /app/publish .

# Expõe a porta padrão do Railway
EXPOSE 8080

# Executa a aplicação
ENTRYPOINT ["dotnet", "Ecommerce.Api.dll"]
