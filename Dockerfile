FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY TodoApi.csproj .
RUN dotnet restore "TodoApi.csproj"
#RUN dotnet run
COPY . .
RUN dotnet publish "TodoApi.csproj" -c Release -o /publish


FROM mcr.microsoft.com/dotnet/aspnet:3.1 as final
WORKDIR /app
COPY --from=build /publish .
EXPOSE 5000
ENTRYPOINT ["dotnet","TodoApi.dll"]
