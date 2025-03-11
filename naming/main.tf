# Terraform naming convention module
# Converted from Bicep version 1.12.1

# Local values (equivalent to Bicep vars)
locals {
  client_affix_title_case  = "${upper(substr(var.client_affix, 0, 1))}${lower(substr(var.client_affix, 1, length(var.client_affix) - 1))}"
  environment_index        = var.env_index > 0 ? tostring(var.env_index) : ""
  project_affix_title_case = "${upper(substr(var.project_affix, 0, 1))}${lower(substr(var.project_affix, 1, length(var.project_affix) - 1))}"
  
  naming_prefix          = var.do_qualify_project_affix ? "${local.client_affix_title_case}${lower(local.project_affix_title_case)}${local.environment_index}" : "${local.project_affix_title_case}${local.environment_index}"
  shared_naming_prefix   = "${var.is_env_prod ? "Pd" : "Npd"}${local.naming_prefix}"
  instance_naming_prefix = "${var.env}${local.naming_prefix}"
  hub_prefix             = lower(var.project_affix)

  resource_names = {
    environment = {
      name                   = lower(var.env)
      shared_naming_prefix   = local.shared_naming_prefix
      instance_naming_prefix = local.instance_naming_prefix
    }
    # Non-prod, prod shared resources
    acr        = "${local.shared_naming_prefix}ShrAcr"
    shared_vnet = "${local.shared_naming_prefix}Vnet"
    adx = {
      name = "${local.shared_naming_prefix}ShrAdx"
      data_connections = {
        alarms_processed = "${lower(var.env)}-adx-alarms-processed"
        telemetry        = "${lower(var.env)}-adx-telemetry"
        twin_history     = "${lower(var.env)}-adx-twin-history"
      }
    }
    dps           = "${local.shared_naming_prefix}ShrDps"
    app_insights  = "${local.shared_naming_prefix}ShrAi"
    log_analytics = "${local.shared_naming_prefix}ShrLa"
    
    # Instance shared resources
    application_gateway = "${local.instance_naming_prefix}ShrAppGw"
    adx_db              = "${local.instance_naming_prefix}AdxDb"
    app_environment     = "${local.instance_naming_prefix}ShrCae"
    digital_twins       = "${local.instance_naming_prefix}ShrAdt"
    cosmos_db           = "${local.instance_naming_prefix}ShrCdb"
    eventhub = {
      namespace = "${local.instance_naming_prefix}ShrEhns"
      hubs = {
        alarms            = "${local.hub_prefix}-alarms"
        alarms_processed  = "${local.hub_prefix}-alarms-processed"
        connectivity      = "${local.hub_prefix}-connectivity"
        events            = "${local.hub_prefix}-events"
        lifecycle         = "${local.hub_prefix}-life-cycle"
        telemetry         = "${local.hub_prefix}-telemetry"
        twins             = "${local.hub_prefix}-twin-changes"
        twin_history      = "${local.hub_prefix}-twin-history"
        processing_errors = "${local.hub_prefix}-processing-errors"
        command_results   = "${local.hub_prefix}-command-results"
      }
    }
    
    container_registry_managed_identity        = "${local.instance_naming_prefix}AcrPullRole"
    event_hub_send_role_managed_identity       = "${local.instance_naming_prefix}EhSendRole"
    event_hub_data_receiver_role_managed_identity = "${local.instance_naming_prefix}EhDataReceiverRole"
    iot_hub_registry_contributor_managed_identity = "${local.instance_naming_prefix}IthRegContributorRole"
    iot_hub_data_contributor_managed_identity  = "${local.instance_naming_prefix}IthDataContributorRole"
    digital_twins_data_owner_managed_identity  = "${local.instance_naming_prefix}AdtDataOwnerRole"
    service_bus_data_receiver_managed_identity = "${local.instance_naming_prefix}SbDataReceiverRole"
    cosmos_db_contributor_managed_identity     = "${local.instance_naming_prefix}CDbContributorRole"
    rg_reader_managed_identity                 = "${local.instance_naming_prefix}RgReaderRole"
    adx_reader_managed_identity                = "${local.instance_naming_prefix}AdxReaderRole"
    
    ioth     = "${local.instance_naming_prefix}ShrIoth"
    key_vault = "${local.instance_naming_prefix}ShrKv"
    
    virtual_network = {
      name    = "${local.instance_naming_prefix}Vnet"
      subnets = {
        default_subnet                   = "General"
        application_gateway_subnet       = "${local.instance_naming_prefix}ShrAppGwSn"
        container_app_environment_subnet = "${local.instance_naming_prefix}ShrCaeSn"
      }
    }
    
    storage = lower("${local.instance_naming_prefix}shrsa")
    
    workbooks = {
      general = "${local.shared_naming_prefix}GeneralSolutionWorkbook"
    }
    
    scripts = {
      managed_identities_check = "${local.instance_naming_prefix}ShrMiCheckScript"
      key_vault_check          = "${local.instance_naming_prefix}ShrKvCheckScript"
    }
    
    ism_action_group = "${local.instance_naming_prefix}IsmTeamAg"
  }
}