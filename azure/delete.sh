#! /bin/bash
clear

# variables
base="zuhid"
resource_group="$base-rg"
location="centralus"
appservice="$base-appservice"
api_cs="$base-api-cs"
web_angular="$base-web-angular"

# delete resource group
az group delete \
  --name $resource_group \
  --yes

# delete appservice plan
az appservice plan delete \
  --resource-group $resource_group \
  --name $appservice \
  --yes

# delete webapp api_cs
az webapp delete \
  --resource-group $resource_group \
  --name $api_cs

# delete webapp web_angular
az webapp delete \
  --resource-group $resource_group \
  --name $web_angular
