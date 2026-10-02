resource denyPublicBlobAccess 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: 'deny-public-blob-access'
  properties: {
    displayName: 'Deny public access on storage accounts'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/4fa4b6c0-31ca-4c0d-b10d-24b96f62a751'
    enforcementMode: 'Default'
  }
}
