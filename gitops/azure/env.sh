export GUID=kjkm7
export CLIENT_ID=3536738d-4913-4c2a-90f7-301b70338bb9
export PASSWORD=Zx_8Q~uHtNXedXAck8NDHwrxhaYtdrsCK-9a5bMp
export TENANT=redhat0.onmicrosoft.com
export SUBSCRIPTION=b33b5334-e865-474a-b5cc-c4c15afa6072
export RESOURCEGROUP=openenv-kjkm7

#curl -L https://aka.ms/InstallAzureCli | bash

az login --service-principal -u $CLIENT_ID -p $PASSWORD --tenant $TENANT

az account set --subscription $SUBSCRIPTION


az ad sp create-for-rbac -n "azure-service-operator" --role contributor \
    --scopes /subscriptions/$SUBSCRIPTION