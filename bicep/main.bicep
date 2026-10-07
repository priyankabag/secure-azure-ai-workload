targetScope = 'subscription'

param location string = 'eastus'
param environment string = 'prod'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-secure-ai-workload-${environment}'
  location: location
}

module identity 'modules/identity.bicep' = {
  name: 'identityDeployment'
  params: {
    location: location
    environment: environment
  }
}

module network 'modules/network.bicep' = {
  name: 'networkDeployment'
  scope: rg
  params: {
    location: location
  }
}

module keyvault 'modules/keyvault.bicep' = {
  name: 'keyvaultDeployment'
  scope: rg
  params: {
    location: location
  }
}
