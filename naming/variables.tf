// Copyright © 2025 Mesh Systems LLC.  All rights reserved.

variable "clientAffix" {
  description = "A 2-4 letter customer affix"
  type        = string
  validation {
    condition     = length(var.clientAffix) >= 2 && length(var.clientAffix) <= 4
    error_message = "Client affix must be between 2 and 4 characters."
  }
}

variable "env" {
  description = "A 2 letter designator for environment"
  type        = string
  validation {
    condition     = contains(["Sd", "Dv", "Ts", "Qa", "Sg", "Npd", "Pd"], var.env)
    error_message = "Environment must be one of: Sd, Dv, Ts, Qa, Sg, Npd, Pd."
  }
}

variable "projectAffix" {
  description = "A 3-9 letter project affix"
  type        = string
  validation {
    condition     = length(var.projectAffix) >= 3 && length(var.projectAffix) <= 9
    error_message = "Project affix must be between 3 and 9 characters."
  }
}

variable "doQualifyProjectAffix" {
  description = "Set to true when the project affix is generic (not a client specific program) ie Remote Monitoring (rmtmon), traXsmart (txs), etc"
  type        = bool
  default     = false
}

variable "isEnvProd" {
  description = "Is this environment production"
  type        = bool
  default     = false
}

variable "envIndex" {
  description = "The environment index - 0 is the default for the initial environment"
  type        = number
  default     = 0
  validation {
    condition     = var.envIndex >= 0 && var.envIndex <= 9
    error_message = "Environment index must be between 0 and 9."
  }
}