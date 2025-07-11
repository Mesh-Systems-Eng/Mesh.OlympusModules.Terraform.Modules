# Mesh Olympus Terraform Modules

This repository contains reusable Terraform modules for Mesh Systems LLC's Olympus platform infrastructure. These modules provide standardized naming conventions and resource configurations for Azure-based IoT and digital twin solutions.

## Overview

The modules in this repository are designed to support Mesh Systems' enterprise IoT platform, providing consistent naming patterns and resource structures across different environments and client implementations.

## Modules

### Naming Module (`naming/`)

The naming module provides standardized naming conventions for Azure resources used in Mesh Systems' Olympus platform. It generates consistent resource names based on client, project, and environment parameters.

#### Features

- **Consistent Naming**: Generates standardized resource names across all environments
- **Environment Support**: Supports multiple environments (Sandbox, Development, Testing, QA, Staging, Non-Production, Production)
- **Client Isolation**: Provides client-specific naming prefixes
- **Resource Type Coverage**: Covers all major Azure resources used in the Olympus platform

#### Usage

```hcl
module "naming" {
  source = "./naming"
  
  clientAffix         = "acme"  # 2-4 letter client identifier
  projectAffix        = "olympus"  # 3-9 letter project identifier
  env                 = "Dv"    # Environment (Sd, Dv, Ts, Qa, Sg, Npd, Pd)
  doQualifyProjectAffix = false # Set to true for generic project affixes
  isEnvProd           = false   # Set to true for production environments
  envIndex            = 0       # Environment index (0-9)
}
```

#### Input Variables

| Variable | Type | Description | Validation |
|----------|------|-------------|------------|
| `clientAffix` | string | 2-4 letter customer affix | Length 2-4 characters |
| `env` | string | 2 letter environment designator | Must be: Sd, Dv, Ts, Qa, Sg, Npd, Pd |
| `projectAffix` | string | 3-9 letter project affix | Length 3-9 characters |
| `doQualifyProjectAffix` | bool | Set to true for generic project affixes | Default: false |
| `isEnvProd` | bool | Is this environment production | Default: false |
| `envIndex` | number | Environment index (0-9) | Range 0-9, default: 0 |

#### Outputs

| Output | Description |
|--------|-------------|
| `sharedNamingPrefix` | Shared naming prefix for cross-environment resources |
| `instanceNamingPrefix` | Instance-specific naming prefix |
| `sharedResourceNames` | Complete mapping of resource names |

#### Generated Resource Names

The module generates names for the following resource types:

**Shared Resources (Non-prod/Prod)**
- Azure Container Registry (ACR)
- Shared Virtual Network
- Azure Data Explorer (ADX)
- Device Provisioning Service (DPS)
- Application Insights
- Log Analytics

**Instance Resources**
- Application Gateway
- ADX Database
- Container App Environment
- Digital Twins
- Cosmos DB
- Event Hub (Namespace and Hubs)
- Managed Identities
- IoT Hub
- Key Vault
- Virtual Network and Subnets
- Storage Account
- Workbooks
- Scripts
- Action Groups

#### Naming Convention Examples

For client "acme" with project "olympus" in development environment:

- **Shared Resources**: `NpdAcmeolympusShrAcr`, `NpdAcmeolympusVnet`
- **Instance Resources**: `DvAcmeolympusShrAppGw`, `DvAcmeolympusShrAdt`
- **Event Hubs**: `olympus-alarms`, `olympus-telemetry`

## Environment Support

The module supports the following environments:

| Environment | Code | Description |
|-------------|------|-------------|
| Sandbox | Sd | Development sandbox environment |
| Development | Dv | Development environment |
| Testing | Ts | Testing environment |
| QA | Qa | Quality assurance environment |
| Staging | Sg | Pre-production staging |
| Non-Production | Npd | Non-production environment |
| Production | Pd | Production environment |

## Contributing

1. Follow the existing naming conventions
2. Ensure all variables have proper validation
3. Update documentation for any new modules
4. Test changes across multiple environments

## License

Copyright © 2025 Mesh Systems LLC. All rights reserved.

## Support

For questions or support regarding these Terraform modules, please contact the Mesh Systems development team. 