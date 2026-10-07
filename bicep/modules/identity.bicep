targetScope = 'subscription'

param location string = 'eastus'
param environment string = 'prod'

// Custom role: least-privilege access for AI workload operators
// Scoped to only read/write on AI-related resources, not full Contributor
resource aiOperatorRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(subscription().id, 'AI-Workload-Operator')
  properties: {
    roleName: 'AI Workload Operator'
    description: 'Custom role for managing AI workload resources with least privilege'
    assignableScopes: [
      subscription().id
    ]
    permissions: [
      {
        actions: [
          'Microsoft.CognitiveServices/*/read'
          'Microsoft.KeyVault/vaults/secrets/read'
        ]
        notActions: []
      }
    ]
  }
}
