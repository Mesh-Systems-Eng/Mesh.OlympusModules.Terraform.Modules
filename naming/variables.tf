variable "env" {
  description = "A 2 letter designator for the environment"
  type        = string
  validation {
    condition     = contains(["Sd", "Dv", "Ts", "Qa", "Sg", "Pd"], var.env)
    error_message = "Allowed values for env are: Sd, Dv, Ts, Qa, Sg, Pd."
  }
}

variable "is_env_prod" {
  description = "Is this environment production"
  type        = bool
  default     = false
}

variable "client_affix" {
  description = "A 2-4 letter client affix"
  type        = string
  validation {
    condition     = length(var.client_affix) >= 2 && length(var.client_affix) <= 4
    error_message = "The client_affix value must be between 2 and 4 characters."
  }
}

variable "project_affix" {
  description = "A 3-9 letter project affix"
  type        = string
  validation {
    condition     = length(var.project_affix) >= 3 && length(var.project_affix) <= 9
    error_message = "The project_affix value must be between 3 and 9 characters."
  }
}

variable "do_qualify_project_affix" {
  description = "Set to true when the project affix is generic (not a client specific program) ie Remote Monitoring (rmtmon), traXsmart (txs), etc"
  type        = bool
  default     = false
}

variable "env_index" {
  description = "The environment index - 0 is the default for the initial environment"
  type        = number
  default     = 0
  validation {
    condition     = var.env_index >= 0 && var.env_index <= 9
    error_message = "The env_index value must be between 0 and 9."
  }
}