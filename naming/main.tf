// Copyright © 2025 Mesh Systems LLC.  All rights reserved.

locals {
  firstCharUpper = { for s in [var.clientAffix, var.projectAffix] : s => upper(substr(s, 0, 1)) }
  restCharsLower = { for s in [var.clientAffix, var.projectAffix] : s => lower(substr(s, 1, length(s) - 1)) }

  clientAffixTitleCase  = "${local.firstCharUpper[var.clientAffix]}${local.restCharsLower[var.clientAffix]}"
  projectAffixTitleCase = "${local.firstCharUpper[var.projectAffix]}${local.restCharsLower[var.projectAffix]}"

  environmentIndex = var.envIndex > 0 ? tostring(var.envIndex) : ""

  namingPrefix         = var.doQualifyProjectAffix ? "${local.clientAffixTitleCase}${lower(local.projectAffixTitleCase)}${local.environmentIndex}" : "${local.projectAffixTitleCase}${local.environmentIndex}"
  sharedNamingPrefix   = "${var.isEnvProd ? "Pd" : "Npd"}${local.namingPrefix}"
  instanceNamingPrefix = "${var.env}${local.namingPrefix}"
  hubPrefix            = lower(var.projectAffix)

  resourceNames = {
    environment = {
      name                 = lower(var.env)
      sharedNamingPrefix   = local.sharedNamingPrefix
      instanceNamingPrefix = local.instanceNamingPrefix
    }

    # Non-prod, prod shared resources
    acr        = "${local.sharedNamingPrefix}ShrAcr"
    sharedVnet = "${local.sharedNamingPrefix}Vnet"
    adx = {
      name = lower("${local.sharedNamingPrefix}ShrAdx")
      dataConnections = {
        alarmsProcessed = "${lower(var.env)}-adx-alarms-processed"
        telemetry       = "${lower(var.env)}-adx-telemetry"
        twinHistory     = "${lower(var.env)}-adx-twin-history"
      }
    }
    dps          = "${local.sharedNamingPrefix}ShrDps"
    appInsights  = "${local.sharedNamingPrefix}ShrAi"
    logAnalytics = "${local.sharedNamingPrefix}ShrLa"

    # Instance shared resources
    applicationGateway = "${local.instanceNamingPrefix}ShrAppGw"
    adxDb              = "${local.instanceNamingPrefix}AdxDb"
    appEnvironment     = "${local.instanceNamingPrefix}ShrCae"
    digitalTwins       = "${local.instanceNamingPrefix}ShrAdt"
    cosmosDb           = "${local.instanceNamingPrefix}ShrCdb"
    eventhub = {
      namespace = "${local.instanceNamingPrefix}ShrEhns"
      hubs = {
        alarms           = "${local.hubPrefix}-alarms"
        alarmsProcessed  = "${local.hubPrefix}-alarms-processed"
        connectivity     = "${local.hubPrefix}-connectivity"
        events           = "${local.hubPrefix}-events"
        lifecycle        = "${local.hubPrefix}-life-cycle"
        telemetry        = "${local.hubPrefix}-telemetry"
        twins            = "${local.hubPrefix}-twin-changes"
        twinHistory      = "${local.hubPrefix}-twin-history"
        processingErrors = "${local.hubPrefix}-processing-errors"
        commandResults   = "${local.hubPrefix}-command-results"
      }
    }
    containerRegistryManagedIdentity         = "${local.instanceNamingPrefix}AcrPullRole"
    eventHubSendRoleManagedIdentity          = "${local.instanceNamingPrefix}EhSendRole"
    eventHubDataReceiverRoleManagedIdentity  = "${local.instanceNamingPrefix}EhDataReceiverRole"
    iotHubRegistryContributorManagedIdentity = "${local.instanceNamingPrefix}IthRegContributorRole"
    iotHubDataContributorManagedIdentity     = "${local.instanceNamingPrefix}IthDataContributorRole"
    digitalTwinsDataOwnerManagedIdentity     = "${local.instanceNamingPrefix}AdtDataOwnerRole"
    serviceBusDataReceiverManagedIdentity    = "${local.instanceNamingPrefix}SbDataReceiverRole"
    cosmosDbContributorManagedIdentity       = "${local.instanceNamingPrefix}CDbContributorRole"
    rgReaderManagedIdentity                  = "${local.instanceNamingPrefix}RgReaderRole"
    adxReaderManagedIdentity                 = "${local.instanceNamingPrefix}AdxReaderRole"
    ioth                                     = "${local.instanceNamingPrefix}ShrIoth"
    keyVault                                 = "${local.instanceNamingPrefix}ShrKv"
    virtualNetwork = {
      name = "${local.instanceNamingPrefix}Vnet"
      subnets = {
        defaultSubnet                 = "General"
        applicationGatewaySubnet      = "${local.instanceNamingPrefix}ShrAppGwSn"
        containerAppEnvironmentSubnet = "${local.instanceNamingPrefix}ShrCaeSn"
      }
    }
    storage = lower("${local.instanceNamingPrefix}shrsa")
    workbooks = {
      general = "${local.sharedNamingPrefix}GeneralSolutionWorkbook"
    }
    scripts = {
      managedIdentitiesCheck = "${local.instanceNamingPrefix}ShrMiCheckScript"
      keyVaultCheck          = "${local.instanceNamingPrefix}ShrKvCheckScript"
    }
    ismActionGroup = "${local.instanceNamingPrefix}IsmTeamAg"
  }
}