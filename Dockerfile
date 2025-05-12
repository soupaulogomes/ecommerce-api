FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copia o .csproj e restaura
COPY *.csproj ./
RUN dotnet restore

# Copia o restante do código e publica
COPY . ./
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Ecommerce.Api.dll"]
