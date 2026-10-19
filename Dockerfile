# UNLATCHED relay server - for hosting your own public server (Render, Railway, Fly.io, any VPS)
# Build:  docker build -t unlatched-server .
# Run:    docker run -p 8080:8080 unlatched-server
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY Shared/ Shared/
COPY UNLATCHED.Server/ UNLATCHED.Server/
RUN dotnet publish UNLATCHED.Server/UNLATCHED.Server.csproj -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app .
# cloud hosts set PORT themselves; 8080 is the default
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "UNLATCHED.Server.dll"]
