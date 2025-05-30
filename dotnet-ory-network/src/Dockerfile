# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine3.16 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY ExampleApp/*.csproj ./ExampleApp/
RUN dotnet restore

# copy everything else and build app
COPY . .
RUN dotnet publish ./ExampleApp/ -c Release -f net7.0 --no-restore -o /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine3.16

# install Ory CLI
RUN wget -q -O - https://raw.githubusercontent.com/ory/meta/master/install.sh | sh -s -- -s -b /usr/local/bin/ ory v0.1.48

WORKDIR /app
COPY --from=build /app ./

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV \
    APP_PORT=5286 \
    ORY_TUNNEL_PORT=4000 \
    ORY_PROJECT_URL=https://playground.projects.oryapis.com \
    COMPlus_EnableDiagnostics=0

EXPOSE ${APP_PORT}
EXPOSE ${ORY_TUNNEL_PORT}

ENTRYPOINT ["/entrypoint.sh"]

CMD ["dotnet", "ExampleApp.dll"]
