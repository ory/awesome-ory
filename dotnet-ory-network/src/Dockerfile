# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:10.0-alpine AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY ExampleApp/*.csproj ./ExampleApp/
RUN dotnet restore

# copy everything else and build app
COPY . .
RUN dotnet publish ./ExampleApp/ -c Release --no-restore -o /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:10.0-alpine

WORKDIR /app
COPY --from=build /app ./

# The SDK uses Docker DNS; browser redirects use the published Kratos API.
ENV \
    APP_PORT=5286 \
    ASPNETCORE_URLS=http://+:5286 \
    ORY_BASEPATH=http://kratos:4433 \
    ORY_BROWSER_URL=http://127.0.0.1:4433 \
    COMPlus_EnableDiagnostics=0

EXPOSE 5286

CMD ["dotnet", "ExampleApp.dll"]
