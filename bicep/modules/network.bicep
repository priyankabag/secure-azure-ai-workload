param location string = 'eastus'

resource hubVnet 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: 'vnet-hub'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'AzureFirewallSubnet'
        properties: { addressPrefix: '10.0.1.0/24' }
      }
    ]
  }
}

resource spokeVnet 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: 'vnet-spoke-ai'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.1.0.0/16']
    }
    subnets: [
      {
        name: 'ai-services-subnet'
        properties: {
          addressPrefix: '10.1.1.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
  }
}
