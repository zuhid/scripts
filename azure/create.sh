#! /bin/bash
clear

# variables
base="zuhid"
resource_group="$base-rg"
location="centralus"
appservice="$base-appservice"
api_cs="$base-api-cs"
web_angular="$base-web-angular"

# create resource group
az group create \
  --name $resource_group \
  --location $location \
  --output table

# create appservice plan
az appservice plan create \
  --name $appservice \
  --resource-group $resource_group \
  --location $location \
  --is-linux \
  --sku B1

# create webapp api_cs
az webapp create \
  --resource-group $resource_group \
  --plan $appservice \
  --name $api_cs \
  --runtime "DOTNETCORE:6.0"

# create webapp web_angular
az webapp create \
  --resource-group $resource_group \
  --plan $appservice \
  --name $web_angular \
  --runtime "PHP:8.0"
