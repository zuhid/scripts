#! /bin/bash
clear

# variables
base="zuhid"
resource_group="$base-rg"
location="centralus"
appservice="$base-appservice"
api_cs="$base-api-cs"
web_angular="$base-web-angular"
sql_server="$base-sql-server"
sql_server_username="admin"
sql_server_password="P@ssw0rd"
sql_server_firewall_rule="$base-sql-server-firewall-rule"
sql_server_db="Identity"

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

az sql server create \
  --resource-group $resource_group \
  --location $location \
  --name $sql_server \
  --admin-user $sql_server_username \
  --admin-password $sql_server_password

az sql server firewall-rule create \
  --resource-group $resource_group \
  --server $sql_server \
  --name $sql_server_firewall_rule \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 0.0.0.0

az sql db create \
  --resource-group $resource_group \
  --server $sql_server \
  --name $sql_server_db \
  --edition Basic
