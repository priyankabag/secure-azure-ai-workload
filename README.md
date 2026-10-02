# Secure Azure + AI Workload

## Overview
A secure Azure baseline for an AI/Copilot-style workload, built with Bicep.
Demonstrates hub-spoke network segmentation, least-privilege identity,
Key Vault with RBAC authorization, and policy-as-code enforcement.

## Architecture
[Diagram to be added — see /architecture]

## Components

### Identity (`bicep/modules/identity.bicep`)
- Resource group to contain all workload resources
- Custom RBAC role ("AI Workload Operator") scoped to read-only access
  on Cognitive Services and Key Vault secrets — avoids using built-in
  Contributor, which would grant far more access than needed

### Network (`bicep/modules/network.bicep`)
- Hub VNet (10.0.0.0/16) hosting Azure Firewall — acts as the
  inspection point for all traffic
- Spoke VNet (10.1.0.0/16) isolating AI workload resources, prepared
  for private endpoint connectivity

### Key Vault (`bicep/modules/keyvault.bicep`)
- RBAC-based authorization instead of legacy access policies —
  enables just-in-time access via PIM
- Soft delete and purge protection enabled — protects against
  accidental or malicious permanent deletion
- Network ACLs default to Deny — vault is unreachable except from
  approved Azure services

### Policy (`bicep/modules/policy.bicep`)
- Enforces denial of public blob access on storage accounts across
  the environment, preventing accidental public data exposure

## Security Decisions
- **RBAC over access policies for Key Vault**: centralizes permission
  management and integrates with PIM for time-bound, just-in-time access.
- **Default-deny network ACLs**: layered on top of RBAC as defense in
  depth — network access is checked before identity/role access, so an
  attacker must defeat both layers, not just one.
- **Least-privilege custom role**: scoped narrowly to what an AI
  workload operator actually needs, rather than broad built-in roles.
- **Hub-spoke network segmentation**: limits lateral movement if any
  single resource is compromised, and centralizes traffic inspection
  through one firewall rather than per-resource controls.

## Status
🚧 In progress — Identity, Network, Key Vault, and Policy modules
complete (SC-500 Modules 1–3). Next: storage/compute hardening
(Modules 4–9), AI threat model (Modules 10–11).

## Threat Model
[To be added — see /threat-model]