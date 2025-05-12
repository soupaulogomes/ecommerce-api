# Use a imagem oficial do .NET SDK 8.0
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Defina o diretório de trabalho no container
WORKDIR /app

# Copie os arquivos do projeto para o container
COPY . ./

# Restaure as dependências do projeto
RUN dotnet restore

# Compile o projeto
RUN dotnet publish -c Release -o /out

# Use a imagem runtime do .NET 8.0 para execução
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Defina o diretório de trabalho no container
WORKDIR /app

# Copie os arquivos compilados do estágio anterior
COPY --from=build /out .

# Exponha a porta usada pela aplicação
EXPOSE 80

# Comando para iniciar a aplicação
ENTRYPOINT ["dotnet", "SeuProjeto.dll"]