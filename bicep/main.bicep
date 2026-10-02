targetScope = 'subscription'

param location string = 'eastus'

module identity 'modules/identity.bicep' = {
  name: 'identityDeployment'
  params: { location: location }
}

module network 'modules/network.bicep' = {
  name: 'networkDeployment'
  params: { location: location }
}

module keyvault 'modules/keyvault.bicep' = {
  name: 'keyvaultDeployment'
  params: { location: location }
}
