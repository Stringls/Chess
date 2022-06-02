#! /bin/bash
rm appsettings.Development.json 
echo '{
  "ConnectionStrings": {
    "ChessDb": "Server='${HOST}', 1433; Database=Chess; User ID=sa; Password='${PASSWORD}'"' >> appsettings.Development.json
echo '},
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
  "SendGridApiKey": "<your_apikey>",
  "EmailSettings": {
    "MyAbvMail": "psp87@abv.bg",
    "MyGmail": "pspetrov1987@gmail.com"
  }
}' >> appsettings.Development.json
 

