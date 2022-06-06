FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
#COPY app.sh .
EXPOSE 5000
EXPOSE 5001
#ARG HOST
#ARG PASSWORD
ENV ASPNETCORE_ENVIRONMENT=Development
ENV ASPNETCORE_URLS=http://0.0.0.0:5000
#ENV HOST=${HOST}
#ENV PASSWORD=${PASSWORD}

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Web/Chess.Web/Chess.Web.csproj", "Web/Chess.Web/"]
RUN dotnet restore "Web/Chess.Web/Chess.Web.csproj"
COPY . .
WORKDIR /src/Web/Chess.Web
RUN dotnet build "Chess.Web.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Chess.Web.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
#CMD ["bash", "app.sh"]
ENTRYPOINT ["dotnet", "Chess.Web.dll"]
